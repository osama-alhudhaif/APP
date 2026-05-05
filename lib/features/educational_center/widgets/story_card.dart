import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/story_model.dart';
import '../../../core/constants/app_constants.dart';

class StoryCard extends StatelessWidget {
  final Story story;
  final VoidCallback? onTap;

  const StoryCard({super.key, required this.story, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final genreLabel = AppConstants.genreLabels[story.genre] ?? story.genre;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap ?? () => context.push('/story/${story.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 72,
                height: 100,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.auto_stories, color: theme.colorScheme.onPrimaryContainer),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.title,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'بقلم: ${story.authorUsername}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (story.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        story.description!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      children: [
                        _badge(context, genreLabel, theme.colorScheme.primaryContainer,
                            theme.colorScheme.onPrimaryContainer),
                        _badge(context, story.language.toUpperCase(),
                            theme.colorScheme.secondaryContainer,
                            theme.colorScheme.onSecondaryContainer),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text(story.averageRating.toStringAsFixed(1),
                            style: theme.textTheme.bodySmall),
                        const SizedBox(width: 12),
                        Icon(Icons.favorite, size: 14,
                            color: theme.colorScheme.onSurfaceVariant),
                        const SizedBox(width: 2),
                        Text('${story.likesCount}', style: theme.textTheme.bodySmall),
                        const SizedBox(width: 12),
                        Icon(Icons.remove_red_eye, size: 14,
                            color: theme.colorScheme.onSurfaceVariant),
                        const SizedBox(width: 2),
                        Text('${story.viewsCount}', style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _badge(BuildContext context, String label, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
      child: Text(label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: fg)),
    );
  }
}
