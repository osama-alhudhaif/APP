const String appName = 'أودا';
const String appVersion = '1.0.0';

class AppConstants {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://192.168.1.5:8000',
  );
  static const String apiVersion = '/api/v1';
  static String get fullBaseUrl => '$baseUrl$apiVersion';

  static const List<String> genres = [
    'fiction',
    'fantasy',
    'sci-fi',
    'mystery',
    'romance',
    'horror',
    'thriller',
    'adventure',
    'drama',
    'poetry',
    'biography',
    'history',
  ];

  static const Map<String, String> genreLabels = {
    'fiction': 'خيال',
    'fantasy': 'فانتازيا',
    'sci-fi': 'خيال علمي',
    'mystery': 'غموض',
    'romance': 'رومانسي',
    'horror': 'رعب',
    'thriller': 'إثارة',
    'adventure': 'مغامرة',
    'drama': 'دراما',
    'poetry': 'شعر',
    'biography': 'سيرة ذاتية',
    'history': 'تاريخ',
  };

  static const List<String> languages = ['ar', 'en', 'fr', 'es', 'de', 'it', 'pt', 'ru', 'zh', 'ja'];

  static const Map<String, String> languageLabels = {
    'ar': 'العربية',
    'en': 'الإنجليزية',
    'fr': 'الفرنسية',
    'es': 'الإسبانية',
    'de': 'الألمانية',
    'it': 'الإيطالية',
    'pt': 'البرتغالية',
    'ru': 'الروسية',
    'zh': 'الصينية',
    'ja': 'اليابانية',
  };
}

class ApiEndpoints {
  // Auth
  static const String login = '/accounts/login/';
  static const String register = '/accounts/register/';
  static const String me = '/accounts/me/';
  static String userProfile(int id) => '/accounts/users/$id/';
  static String followUser(int id) => '/accounts/users/$id/follow/';
  static const String notifications = '/accounts/notifications/';
  static String markNotificationRead(int id) => '/accounts/notifications/$id/mark-read/';

  // Stories
  static const String stories = '/stories/stories/';
  static String storyDetail(int id) => '/stories/stories/$id/';
  static String storyLike(int id) => '/stories/stories/$id/like/';
  static String storyIsLiked(int id) => '/stories/stories/$id/is_liked/';
  static String storyComments(int id) => '/stories/stories/$id/comments/';
  static String storyRatings(int id) => '/stories/stories/$id/ratings/';
  static String storyMyRating(int id) => '/stories/stories/$id/my-rating/';

  // Translation
  static const String translate = '/stories/translate/';
  static const String translateLanguages = '/stories/translate/languages/';
}
