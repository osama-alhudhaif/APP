import 'dart:convert';
import '../models/story_model.dart';
import '../models/comment_model.dart';
import 'api_service.dart';
import '../../core/constants/app_constants.dart';

class StoryService {
  final ApiService _api = ApiService();

  Future<List<Story>> getStories({int page = 1, String? search, String? genre}) async {
    final params = <String, String>{'page': page.toString()};
    if (search != null && search.isNotEmpty) params['search'] = search;
    if (genre != null && genre.isNotEmpty) params['genre'] = genre;

    final response = await _api.get(ApiEndpoints.stories, queryParams: params);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] ?? data;
      return (results as List).map((j) => Story.fromJson(j as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<Story?> getStory(int id) async {
    final response = await _api.get(ApiEndpoints.storyDetail(id), requiresAuth: true);
    if (response.statusCode == 200) {
      return Story.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    return null;
  }

  Future<Story?> uploadStory(Map<String, String> fields, String filePath, String fileName) async {
    final response = await _api.multipartPost(
      ApiEndpoints.stories,
      fields: fields,
      fileField: 'file_path',
      filePath: filePath,
      fileName: fileName,
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Story.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    return null;
  }

  Future<Map<String, dynamic>?> toggleLike(int id) async {
    final response = await _api.post(ApiEndpoints.storyLike(id), requiresAuth: true);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return null;
  }

  Future<bool?> isLiked(int id) async {
    final response = await _api.get(ApiEndpoints.storyIsLiked(id), requiresAuth: true);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['liked'] as bool?;
    }
    return null;
  }

  Future<List<Comment>> getComments(int storyId) async {
    final response = await _api.get(ApiEndpoints.storyComments(storyId), requiresAuth: true);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final results = data['results'] ?? data;
      return (results as List).map((j) => Comment.fromJson(j as Map<String, dynamic>)).toList();
    }
    return [];
  }

  Future<Comment?> addComment(int storyId, String content) async {
    final response = await _api.post(
      ApiEndpoints.storyComments(storyId),
      requiresAuth: true,
      body: {'content': content},
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Comment.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }
    return null;
  }

  Future<bool> submitRating(int storyId, int rating) async {
    final response = await _api.post(
      ApiEndpoints.storyRatings(storyId),
      requiresAuth: true,
      body: {'rating': rating},
    );
    return response.statusCode == 201 || response.statusCode == 200;
  }

  Future<String?> translateText(String text, String sourceLang, String targetLang) async {
    final response = await _api.post(
      ApiEndpoints.translate,
      requiresAuth: true,
      body: {'text': text, 'source_lang': sourceLang, 'target_lang': targetLang},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data['translated_text'] as String?;
    }
    return null;
  }
}
