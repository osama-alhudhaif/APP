import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/providers/language_provider.dart';
import '../../authentication/providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final auth = context.watch<AuthProvider>();
    final lang = context.watch<LanguageProvider>();
    final s = lang.strings;

    return Scaffold(
      appBar: AppBar(title: Text(s.settings)),
      body: ListView(
        children: [
          // اختيار اللغة
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(s.language,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SegmentedButton<String>(
              segments: [
                ButtonSegment(value: 'ar', label: Text(s.arabic), icon: const Text('🇸🇦')),
                ButtonSegment(value: 'en', label: Text(s.english), icon: const Text('🇬🇧')),
              ],
              selected: {lang.locale.languageCode},
              onSelectionChanged: (set) => lang.setLanguage(set.first),
            ),
          ),
          const Divider(),

          // الوضع الداكن
          SwitchListTile(
            secondary: Icon(
                theme.isDarkMode ? Icons.dark_mode : Icons.light_mode_outlined),
            title: Text(s.darkMode),
            subtitle: Text(s.isArabic ? 'تغيير مظهر التطبيق' : 'Change app appearance'),
            value: theme.isDarkMode,
            onChanged: (val) async {
              await theme.setDarkMode(val);
              if (auth.isLoggedIn) {
                await auth.updateProfile({'dark_mode_enabled': val});
              }
            },
          ),
          const Divider(),

          if (auth.isLoggedIn) ...[
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: Text(s.myProfile),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/profile/me'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(s.logout),
              onTap: () async {
                await auth.logout();
                if (context.mounted) context.go('/login');
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.delete_forever,
                  color: Theme.of(context).colorScheme.error),
              title: Text(s.deleteAccount,
                  style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () => context.push('/delete-account'),
            ),
          ],
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(s.isArabic ? 'الإصدار' : 'Version'),
            trailing: const Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}
