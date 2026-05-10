import 'package:flutter/material.dart';

class AppStrings {
  final String languageCode;

  const AppStrings._(this.languageCode);

  bool get isArabic => languageCode == 'ar';

  // ===== عام =====
  String get appName => 'أودا';
  String get loading => isArabic ? 'جاري التحميل...' : 'Loading...';
  String get save => isArabic ? 'حفظ' : 'Save';
  String get cancel => isArabic ? 'إلغاء' : 'Cancel';
  String get error => isArabic ? 'خطأ' : 'Error';
  String get success => isArabic ? 'تم بنجاح' : 'Success';
  String get serverError => isArabic ? 'تعذر الاتصال بالخادم' : 'Could not connect to server';
  String get retry => isArabic ? 'إعادة المحاولة' : 'Retry';
  String get close => isArabic ? 'إغلاق' : 'Close';
  String get confirm => isArabic ? 'تأكيد' : 'Confirm';

  // ===== تسجيل الدخول =====
  String get loginTitle => isArabic ? 'مرحباً بك في أودا' : 'Welcome to Oda';
  String get loginSubtitle => isArabic ? 'سجّل الدخول للمتابعة' : 'Sign in to continue';
  String get username => isArabic ? 'اسم المستخدم' : 'Username';
  String get password => isArabic ? 'كلمة المرور' : 'Password';
  String get login => isArabic ? 'تسجيل الدخول' : 'Log In';
  String get logout => isArabic ? 'تسجيل الخروج' : 'Log Out';
  String get forgotPassword => isArabic ? 'نسيت كلمة المرور؟' : 'Forgot password?';
  String get noAccount => isArabic ? 'ليس لديك حساب؟ سجّل الآن' : "Don't have an account? Sign up";
  String get usernameRequired => isArabic ? 'يرجى إدخال اسم المستخدم' : 'Please enter your username';
  String get passwordRequired => isArabic ? 'يرجى إدخال كلمة المرور' : 'Please enter your password';
  String get invalidCredentials => isArabic ? 'خطأ في اسم المستخدم أو كلمة المرور' : 'Invalid username or password';

  // ===== التسجيل =====
  String get registerTitle => isArabic ? 'إنشاء حساب جديد' : 'Create New Account';
  String get email => isArabic ? 'البريد الإلكتروني' : 'Email';
  String get confirmPassword => isArabic ? 'تأكيد كلمة المرور' : 'Confirm Password';
  String get register => isArabic ? 'إنشاء حساب' : 'Sign Up';
  String get haveAccount => isArabic ? 'لديك حساب؟ سجّل الدخول' : 'Already have an account? Log in';
  String get emailRequired => isArabic ? 'يرجى إدخال البريد الإلكتروني' : 'Please enter your email';
  String get passwordsNotMatch => isArabic ? 'كلمتا المرور غير متطابقتين' : 'Passwords do not match';

  // ===== القصص =====
  String get stories => isArabic ? 'القصص' : 'Stories';
  String get myStories => isArabic ? 'قصصي' : 'My Stories';
  String get uploadStory => isArabic ? 'نشر قصة' : 'Publish Story';
  String get storyTitle => isArabic ? 'عنوان القصة' : 'Story Title';
  String get storyDescription => isArabic ? 'وصف القصة' : 'Story Description';
  String get genre => isArabic ? 'النوع' : 'Genre';
  String get publishStory => isArabic ? 'نشر القصة' : 'Publish Story';
  String get publishing => isArabic ? 'جاري النشر...' : 'Publishing...';
  String get noStories => isArabic ? 'لا توجد قصص بعد.' : 'No stories yet.';
  String get readMore => isArabic ? 'قراءة المزيد' : 'Read More';
  String get views => isArabic ? 'مشاهدة' : 'views';
  String get likes => isArabic ? 'إعجاب' : 'likes';
  String get searchHint => isArabic ? 'ابحث عن قصة، كاتب، أو نوع...' : 'Search for a story, author, or genre...';
  String get search => isArabic ? 'بحث' : 'Search';

  // ===== الفئات =====
  String get chooseCategory => isArabic ? 'اختر الفئة' : 'Choose Category';
  String genreName(String key) {
    const ar = {
      'war': 'حرب', 'sci-fi': 'خيال علمي', 'action': 'أكشن',
      'fantasy': 'الفانتازيا', 'mystery': 'الجريمة والغموض',
      'horror': 'الرعب', 'history': 'القصص التاريخية',
      'heist': 'سرقة', 'adventure': 'المغامرات', 'romance': 'رومانسية',
    };
    const en = {
      'war': 'War', 'sci-fi': 'Sci-Fi', 'action': 'Action',
      'fantasy': 'Fantasy', 'mystery': 'Crime & Mystery',
      'horror': 'Horror', 'history': 'Historical Stories',
      'heist': 'Heist', 'adventure': 'Adventure', 'romance': 'Romance',
    };
    return isArabic ? (ar[key] ?? key) : (en[key] ?? key);
  }

  // ===== الملف الشخصي =====
  String get myProfile => isArabic ? 'ملفي الشخصي' : 'My Profile';
  String get editProfile => isArabic ? 'تعديل الملف الشخصي' : 'Edit Profile';
  String get follow => isArabic ? 'متابعة' : 'Follow';
  String get unfollow => isArabic ? 'إلغاء المتابعة' : 'Unfollow';
  String get followers => isArabic ? 'المتابعون' : 'Followers';
  String get following => isArabic ? 'المتابَعون' : 'Following';
  String get bio => isArabic ? 'نبذة تعريفية' : 'Bio';

  // ===== الإشعارات =====
  String get notifications => isArabic ? 'الإشعارات' : 'Notifications';
  String get markAllRead => isArabic ? 'تعليم الكل كمقروء' : 'Mark all as read';
  String get noNotifications => isArabic ? 'لا توجد إشعارات حتى الآن' : 'No notifications yet';

  // ===== الإعدادات =====
  String get settings => isArabic ? 'الإعدادات' : 'Settings';
  String get language => isArabic ? 'اللغة' : 'Language';
  String get arabic => isArabic ? 'العربية' : 'Arabic';
  String get english => isArabic ? 'الإنجليزية' : 'English';
  String get darkMode => isArabic ? 'الوضع الداكن' : 'Dark Mode';
  String get changePassword => isArabic ? 'تغيير كلمة المرور' : 'Change Password';
  String get deleteAccount => isArabic ? 'حذف الحساب' : 'Delete Account';

  // ===== التنقل =====
  String get home => isArabic ? 'الرئيسية' : 'Home';
  String get discover => isArabic ? 'استكشاف' : 'Discover';
  String get library => isArabic ? 'مكتبتي' : 'Library';

  static AppStrings of(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return AppStrings._(locale.languageCode);
  }

  static AppStrings fromCode(String code) => AppStrings._(code);
}
