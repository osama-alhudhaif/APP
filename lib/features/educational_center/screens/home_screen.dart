import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/story_provider.dart';
import '../widgets/story_card.dart';
import '../../authentication/providers/auth_provider.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StoryProvider>().fetchStories();
    });
    _scrollCtrl.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollCtrl.position.pixels >= _scrollCtrl.position.maxScrollExtent - 200) {
      final provider = context.read<StoryProvider>();
      if (!provider.isLoading && provider.hasMore) {
        provider.fetchMore();
      }
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stories = context.watch<StoryProvider>();
    final auth = context.watch<AuthProvider>();
    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('أودا', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(theme.isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
            onPressed: () => theme.toggleTheme(),
          ),
          if (auth.isLoggedIn)
            IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () => context.push('/profile/me'),
            )
          else
            IconButton(
              icon: const Icon(Icons.login),
              onPressed: () => context.push('/login'),
            ),
          if (auth.isLoggedIn)
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () => context.push('/settings'),
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'ابحث عن قصة...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchCtrl.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchCtrl.clear();
                          stories.setSearch(null);
                        },
                      )
                    : null,
              ),
              onSubmitted: (v) => stories.setSearch(v),
              onChanged: (v) {
                setState(() {});
                if (v.isEmpty) stories.setSearch(null);
              },
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _genreChip(context, stories, null, 'الكل'),
                ...AppConstants.genres.map((g) => _genreChip(
                    context, stories, g, AppConstants.genreLabels[g] ?? g)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: stories.isLoading && stories.stories.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : stories.error != null && stories.stories.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                size: 48, color: Theme.of(context).colorScheme.error),
                            const SizedBox(height: 16),
                            Text(stories.error!),
                            const SizedBox(height: 16),
                            FilledButton.icon(
                              onPressed: () => stories.fetchStories(),
                              icon: const Icon(Icons.refresh),
                              label: const Text('إعادة المحاولة'),
                            ),
                          ],
                        ),
                      )
                    : stories.stories.isEmpty
                        ? const Center(child: Text('لا توجد قصص متاحة'))
                        : RefreshIndicator(
                            onRefresh: () => stories.fetchStories(),
                            child: ListView.builder(
                              controller: _scrollCtrl,
                              padding: const EdgeInsets.all(16),
                              itemCount: stories.stories.length + (stories.hasMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index == stories.stories.length) {
                                  return const Center(
                                      child: Padding(
                                          padding: EdgeInsets.all(16),
                                          child: CircularProgressIndicator()));
                                }
                                return StoryCard(story: stories.stories[index]);
                              },
                            ),
                          ),
          ),
        ],
      ),
      floatingActionButton: auth.isLoggedIn && (auth.user?.isWriter ?? false)
          ? FloatingActionButton.extended(
              onPressed: () => context.push('/add-story'),
              icon: const Icon(Icons.add),
              label: const Text('قصة جديدة'),
            )
          : null,
    );
  }

  Widget _genreChip(BuildContext context, StoryProvider provider, String? genre, String label) {
    final selected = provider.selectedGenre == genre;
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: FilterChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => provider.setGenre(genre),
      ),
    );
  }
}
