import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../authentication/providers/auth_provider.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  bool _editMode = false;
  late TextEditingController _firstNameCtrl;
  late TextEditingController _lastNameCtrl;

  @override
  void initState() {
    super.initState();
    final u = context.read<AuthProvider>().user;
    _firstNameCtrl = TextEditingController(text: u?.firstName ?? '');
    _lastNameCtrl = TextEditingController(text: u?.lastName ?? '');
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final auth = context.read<AuthProvider>();
    final ok = await auth.updateProfile({
      'first_name': _firstNameCtrl.text.trim(),
      'last_name': _lastNameCtrl.text.trim(),
    });
    if (ok && mounted) {
      setState(() => _editMode = false);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم حفظ التغييرات')));
    }
  }

  String _roleLabel(String role) {
    switch (role) {
      case 'writer': return 'كاتب';
      case 'both': return 'قارئ وكاتب';
      default: return 'قارئ';
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.user;
    final theme = Theme.of(context);

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('ملفي الشخصي')),
        body: Center(
          child: FilledButton(
            onPressed: () => context.go('/login'),
            child: const Text('تسجيل الدخول'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('ملفي الشخصي'),
        actions: [
          if (_editMode)
            IconButton(
              icon: const Icon(Icons.save_outlined),
              onPressed: _saveProfile,
            )
          else
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => setState(() => _editMode = true),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: 52,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Text(
                  user.username.isNotEmpty ? user.username[0].toUpperCase() : 'U',
                  style: theme.textTheme.displaySmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(user.username,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            Text(user.email,
                style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statBlock(context, '${user.followersCount}', 'المتابعون'),
                Container(width: 1, height: 40, color: theme.colorScheme.outlineVariant),
                _statBlock(context, '${user.followingCount}', 'يتابع'),
              ],
            ),
            const Divider(height: 32),
            if (_editMode) ...[
              TextFormField(
                controller: _firstNameCtrl,
                decoration: const InputDecoration(labelText: 'الاسم الأول'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _lastNameCtrl,
                decoration: const InputDecoration(labelText: 'الاسم الأخير'),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: _saveProfile,
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                child: const Text('حفظ'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => setState(() => _editMode = false),
                style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                child: const Text('إلغاء'),
              ),
            ] else ...[
              ListTile(
                leading: const Icon(Icons.badge_outlined),
                title: Text(user.fullName.isEmpty ? 'غير محدد' : user.fullName),
                subtitle: const Text('الاسم الكامل'),
              ),
              ListTile(
                leading: const Icon(Icons.work_outline),
                title: Text(_roleLabel(user.role)),
                subtitle: const Text('الدور'),
              ),
              if (user.country != null && user.country!.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(user.country!),
                  subtitle: const Text('البلد'),
                ),
              if (user.hasActiveSubscription)
                ListTile(
                  leading: Icon(Icons.workspace_premium,
                      color: Colors.amber),
                  title: const Text('مشترك نشط'),
                  subtitle: const Text('الاشتراك'),
                ),
            ],
            const Divider(height: 32),
            FilledButton.tonal(
              onPressed: () async {
                await auth.logout();
                if (mounted) context.go('/login');
              },
              style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              child: const Text('تسجيل الخروج'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.push('/delete-account'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                foregroundColor: theme.colorScheme.error,
                side: BorderSide(color: theme.colorScheme.error),
              ),
              child: const Text('حذف الحساب'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statBlock(BuildContext context, String value, String label) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(value,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        Text(label,
            style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant)),
      ],
    );
  }
}
