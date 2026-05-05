import 'package:flutter/material.dart';
import '../../../data/models/story_model.dart';
import '../../../data/models/comment_model.dart';
import '../../../data/services/story_service.dart';
import '../../../core/constants/app_constants.dart';

class StoryProvider extends ChangeNotifier {
  final StoryService _service = StoryService();

  List<Story> _stories = [];
  Story? _selectedStory;
  List<Comment> _comments = [];
  bool _isLoading = false;
  String? _error;
  bool _isLiked = false;
  int _currentPage = 1;
  bool _hasMore = true;
  String? _searchQuery;
  String? _selectedGenre;

  List<Story> get stories => _stories;
  Story? get selectedStory => _selectedStory;
  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLiked => _isLiked;
  bool get hasMore => _hasMore;
  String? get selectedGenre => _selectedGenre;
  String? get searchQuery => _searchQuery;

  List<String> get genres => AppConstants.genres;

  Future<void> fetchStories({bool refresh = true}) async {
    if (refresh) {
      _currentPage = 1;
      _hasMore = true;
      _stories = [];
    }
    if (!_hasMore) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    final results = await _service.getStories(
      page: _currentPage,
      search: _searchQuery,
      genre: (_selectedGenre != null && _selectedGenre != 'all') ? _selectedGenre : null,
    );

    if (results.isEmpty && _currentPage > 1) {
      _hasMore = false;
    } else {
      if (refresh) {
        _stories = results;
      } else {
        _stories.addAll(results);
      }
      if (results.length < 20) _hasMore = false;
      _currentPage++;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMore() => fetchStories(refresh: false);

  Future<void> fetchStoryDetail(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    _selectedStory = await _service.getStory(id);
    if (_selectedStory == null) _error = 'فشل في تحميل القصة';

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchComments(int storyId) async {
    _comments = await _service.getComments(storyId);
    notifyListeners();
  }

  Future<bool> addComment(int storyId, String content) async {
    final comment = await _service.addComment(storyId, content);
    if (comment != null) {
      _comments = [comment, ..._comments];
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> checkIsLiked(int storyId) async {
    final liked = await _service.isLiked(storyId);
    _isLiked = liked ?? false;
    notifyListeners();
  }

  Future<void> toggleLike(int storyId) async {
    final result = await _service.toggleLike(storyId);
    if (result != null) {
      _isLiked = result['liked'] as bool? ?? !_isLiked;
      final newCount = result['likes_count'] as int?;
      if (_selectedStory != null && newCount != null) {
        _selectedStory = _selectedStory!.copyWith(likesCount: newCount);
      }
      notifyListeners();
    }
  }

  Future<bool> submitRating(int storyId, int rating) async {
    return _service.submitRating(storyId, rating);
  }

  Future<String?> translateText(String text, String sourceLang, String targetLang) {
    return _service.translateText(text, sourceLang, targetLang);
  }

  void setSearch(String? query) {
    _searchQuery = (query != null && query.isNotEmpty) ? query : null;
    fetchStories();
  }

  void setGenre(String? genre) {
    _selectedGenre = genre;
    fetchStories();
  }

  void clearFilters() {
    _searchQuery = null;
    _selectedGenre = null;
    fetchStories();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
