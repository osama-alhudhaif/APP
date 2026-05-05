import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/story_provider.dart';
import '../../authentication/providers/auth_provider.dart';
import '../../../core/constants/app_constants.dart';

class StoryDetailScreen extends StatefulWidget {
  final int storyId;

  const StoryDetailScreen({super.key, required this.storyId});

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  final _commentCtrl = TextEditingController();
  int _pendingRating = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final sp = context.read<StoryProvider>();
      sp.fetchStoryDetail(widget.storyId);
      sp.fetchComments(widget.storyId);
      sp.checkIsLiked(widget.storyId);
    });
  }

  @override
  void dispose() {
    _commentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<StoryProvider>();
    final auth = context.watch<AuthProvider>();
    final theme = Theme.of(context);
    final story = sp.selectedStory;

    if (sp.isLoading && story == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('تفاصيل القصة')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (story == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('تفاصيل القصة')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              const Text('لم يتم العثور على القصة'),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('رجوع'),
              ),
            ],
          ),
        ),
      );
    }

    final genreLabel = AppConstants.genreLabels[story.genre] ?? story.genre;

    return Scaffold(
      appBar: AppBar(title: Text(story.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & author
            Text(story.title,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => context.push('/profile/${story.author}'),
              child: Text(
                'بقلم: ${story.authorUsername}',
                style: theme.textTheme.bodyLarge
                    ?.copyWith(color: theme.colorScheme.primary),
              ),
            ),
            const SizedBox(height: 12),

            // Genre, language, stats chips
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                Chip(
                  label: Text(genreLabel),
                  backgroundColor: theme.colorScheme.primaryContainer,
                  labelStyle:
                      TextStyle(color: theme.colorScheme.onPrimaryContainer),
                ),
                Chip(
                  label: Text(story.language.toUpperCase()),
                  backgroundColor: theme.colorScheme.secondaryContainer,
                  labelStyle:
                      TextStyle(color: theme.colorScheme.onSecondaryContainer),
                ),
                ...story.tags.map((t) => Chip(label: Text(t))),
              ],
            ),
            const SizedBox(height: 12),

            // Stats row
            Row(
              children: [
                Icon(Icons.star, size: 18, color: Colors.amber),
                const SizedBox(width: 4),
                Text('${story.averageRating.toStringAsFixed(1)} (${story.ratingsCount})',
                    style: theme.textTheme.bodyMedium),
                const SizedBox(width: 16),
                Icon(Icons.remove_red_eye, size: 18,
                    color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text('${story.viewsCount}', style: theme.textTheme.bodyMedium),
                const SizedBox(width: 16),
                Icon(Icons.comment_outlined, size: 18,
                    color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text('${story.commentsCount}', style: theme.textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            if (story.description != null && story.description!.isNotEmpty) ...[
              Text('الوصف',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(story.description!, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 16),
            ],

            // Action buttons row
            Row(
              children: [
                // Like button
                if (auth.isLoggedIn)
                  IconButton.filled(
                    onPressed: () => sp.toggleLike(widget.storyId),
                    icon: Icon(sp.isLiked ? Icons.favorite : Icons.favorite_border),
                    style: IconButton.styleFrom(
                      backgroundColor: sp.isLiked
                          ? Colors.red.withAlpha(200)
                          : theme.colorScheme.surfaceContainerHighest,
                      foregroundColor: sp.isLiked ? Colors.white : null,
                    ),
                  ),
                const SizedBox(width: 4),
                Text('${story.likesCount}', style: theme.textTheme.bodyMedium),
                const Spacer(),
                // Rating
                if (auth.isLoggedIn)
                  TextButton.icon(
                    onPressed: () => _showRatingDialog(context, sp),
                    icon: const Icon(Icons.star_outline),
                    label: const Text('قيّم'),
                  ),
                const SizedBox(width: 8),
                // Read button
                FilledButton.icon(
                  onPressed: () => context.push('/read/${story.id}'),
                  icon: const Icon(Icons.menu_book),
                  label: const Text('اقرأ القصة'),
                ),
              ],
            ),
            const Divider(height: 32),

            // Comments section
            Text('التعليقات',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            if (auth.isLoggedIn) ...[
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentCtrl,
                      decoration:
                          const InputDecoration(hintText: 'أضف تعليقاً...'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      final text = _commentCtrl.text.trim();
                      if (text.isEmpty) return;
                      final ok = await sp.addComment(widget.storyId, text);
                      if (ok) _commentCtrl.clear();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            ...sp.comments.map((c) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              child: Text(c.userUsername.isNotEmpty
                                  ? c.userUsername[0].toUpperCase()
                                  : '?'),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(c.userUsername,
                                    style: theme.textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    '${c.createdAt.day}/${c.createdAt.month}/${c.createdAt.year}',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurfaceVariant)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(c.content),
                      ],
                    ),
                  ),
                )),

            if (sp.comments.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text('لا توجد تعليقات بعد',
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showRatingDialog(BuildContext context, StoryProvider sp) {
    int selected = _pendingRating;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: const Text('تقييم القصة'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (i) => IconButton(
                icon: Icon(i < selected ? Icons.star : Icons.star_border,
                    color: Colors.amber, size: 36),
                onPressed: () => setS(() => selected = i + 1),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx), child: const Text('إلغاء')),
            FilledButton(
              onPressed: selected > 0
                  ? () async {
                      Navigator.pop(ctx);
                      final ok = await sp.submitRating(widget.storyId, selected);
                      if (ok) setState(() => _pendingRating = selected);
                    }
                  : null,
              child: const Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }
}
