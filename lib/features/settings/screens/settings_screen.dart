import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/theme_provider.dart';
import '../../authentication/providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(
        children: [
          SwitchListTile(
            secondary: Icon(
                theme.isDarkMode ? Icons.dark_mode : Icons.light_mode_outlined),
            title: const Text('الوضع الداكن'),
            subtitle: const Text('تغيير مظهر التطبيق'),
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
              title: const Text('ملفي الشخصي'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/profile/me'),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('تسجيل الخروج'),
              onTap: () async {
                await auth.logout();
                if (context.mounted) context.go('/login');
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.delete_forever,
                  color: Theme.of(context).colorScheme.error),
              title: Text('حذف الحساب',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () => context.push('/delete-account'),
            ),
          ],
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('الإصدار'),
            trailing: const Text('1.0.0'),
          ),
        ],
      ),
    );
  }
}
