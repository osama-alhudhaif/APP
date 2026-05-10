import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../localization/app_strings.dart';

class LanguageProvider extends ChangeNotifier {
  static const _key = 'oda_language';

  Locale _locale = const Locale('ar');

  Locale get locale => _locale;
  AppStrings get strings => AppStrings.fromCode(_locale.languageCode);
  bool get isArabic => _locale.languageCode == 'ar';

  Future<void> init(Locale deviceLocale) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    if (saved != null) {
      _locale = Locale(saved);
    } else {
      // اكتشاف لغة الجهاز: إذا كانت عربية → عربي، غير ذلك → إنجليزي
      final code = deviceLocale.languageCode;
      _locale = (code == 'ar') ? const Locale('ar') : const Locale('en');
    }
    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    if (_locale.languageCode == code) return;
    _locale = Locale(code);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, code);
    notifyListeners();
  }
}
