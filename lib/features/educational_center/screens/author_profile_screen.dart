import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../data/models/author_model.dart';
import '../../../data/services/api_service.dart';
import '../../../core/constants/app_constants.dart';
import '../../authentication/providers/auth_provider.dart';
import '../providers/story_provider.dart';
import '../widgets/story_card.dart';

class AuthorProfileScreen extends StatefulWidget {
  final int authorId;

  const AuthorProfileScreen({super.key, required this.authorId});

  @override
  State<AuthorProfileScreen> createState() => _AuthorProfileScreenState();
}

class _AuthorProfileScreenState extends State<AuthorProfileScreen> {
  Author? _author;
  bool _isLoading = true;
  String? _error;
  final _api = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await _api.get(
        ApiEndpoints.userProfile(widget.authorId),
        requiresAuth: true,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        setState(() {
          _author = Author.fromJson(data);
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'فشل في تحميل الملف الشخصي';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'حدث خطأ: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleFollow() async {
    if (_author == null) return;
    final response = await _api.post(
      ApiEndpoints.followUser(widget.authorId),
      requiresAuth: true,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        _author = _author!.copyWith(
          isFollowing: !_author!.isFollowing,
          followersCount: _author!.isFollowing
              ? _author!.followersCount - 1
              : _author!.followersCount + 1,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final theme = Theme.of(context);

    if (!auth.isAuthenticated) {
      return Scaffold(
        appBar: AppBar(title: const Text('ملف الكاتب')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, size: 64),
              const SizedBox(height: 16),
              const Text('تسجيل الدخول مطلوب'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.push('/login'),
                child: const Text('تسجيل الدخول'),
              ),
            ],
          ),
        ),
      );
    }

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('ملف الكاتب')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null || _author == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('ملف الكاتب')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text(_error ?? 'لم يتم العثور على الكاتب'),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _fetchProfile,
                icon: const Icon(Icons.refresh),
                label: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(_author!.username)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              color: theme.colorScheme.surfaceContainerHighest,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _author!.profileImage != null
                        ? NetworkImage(_author!.profileImage!)
                        : null,
                    child: _author!.profileImage == null
                        ? Text(_author!.username[0].toUpperCase(),
                            style: theme.textTheme.headlineMedium)
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(_author!.username,
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  if (_author!.bio != null) ...[
                    const SizedBox(height: 8),
                    Text(_author!.bio!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                        textAlign: TextAlign.center),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _stat(context, '${_author!.followersCount}', 'المتابعون'),
                      Container(width: 1, height: 40, margin: const EdgeInsets.symmetric(horizontal: 24),
                          color: theme.colorScheme.outlineVariant),
                      _stat(context, '${_author!.storiesCount}', 'القصص'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _toggleFollow,
                    icon: Icon(_author!.isFollowing
                        ? Icons.person_remove_outlined
                        : Icons.person_add_outlined),
                    label: Text(_author!.isFollowing ? 'إلغاء المتابعة' : 'متابعة'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('قصص الكاتب',
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Consumer<StoryProvider>(
                    builder: (context, sp, _) {
                      final authorStories =
                          sp.stories.where((s) => s.author == widget.authorId).toList();
                      if (authorStories.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              Icon(Icons.book_outlined, size: 48,
                                  color: theme.colorScheme.onSurfaceVariant),
                              const SizedBox(height: 16),
                              const Text('لا توجد قصص متاحة'),
                            ],
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: authorStories.length,
                        itemBuilder: (_, i) => StoryCard(story: authorStories[i]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(BuildContext context, String value, String label) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(value,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        Text(label,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }
}
