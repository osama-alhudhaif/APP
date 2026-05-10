import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/theme/theme_provider.dart';
import 'core/routing/app_router.dart';
import 'core/providers/language_provider.dart';
import 'features/authentication/providers/auth_provider.dart';
import 'features/educational_center/providers/story_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authProvider = AuthProvider();
  await authProvider.init();
  runApp(MyApp(authProvider: authProvider));
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;

  const MyApp({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => StoryProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: _AppRoot(authProvider: authProvider),
    );
  }
}

class _AppRoot extends StatefulWidget {
  final AuthProvider authProvider;
  const _AppRoot({required this.authProvider});

  @override
  State<_AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<_AppRoot> {
  @override
  void initState() {
    super.initState();
    // اكتشاف لغة الجهاز عند أول تشغيل، ثم احترام تفضيل المستخدم المحفوظ
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
      context.read<LanguageProvider>().init(deviceLocale);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final languageProvider = context.watch<LanguageProvider>();

    return MaterialApp.router(
      title: 'أودا',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router(widget.authProvider),
      themeMode: themeProvider.themeMode,
      theme: themeProvider.lightTheme,
      darkTheme: themeProvider.darkTheme,
      locale: languageProvider.locale,
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
