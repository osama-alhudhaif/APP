import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../../../core/providers/language_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  String _gender = 'male';
  String _role = 'reader';
  bool _obscure = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    final auth = context.read<AuthProvider>();
    final s = context.read<LanguageProvider>().strings;
    final ok = await auth.register({
      'username': _usernameCtrl.text.trim(),
      'email': _emailCtrl.text.trim(),
      'first_name': _firstNameCtrl.text.trim(),
      'last_name': _lastNameCtrl.text.trim(),
      'password': _passwordCtrl.text,
      'password_confirm': _confirmCtrl.text,
      'gender': _gender,
      'role': _role,
    });

    if (!mounted) return;
    if (ok) {
      if (auth.isLoggedIn) {
        context.go('/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.isArabic
              ? 'تم إنشاء الحساب، يرجى تسجيل الدخول'
              : 'Account created, please log in')));
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final theme = Theme.of(context);
    final s = context.watch<LanguageProvider>().strings;
    final required = s.isArabic ? 'مطلوب' : 'Required';

    return Scaffold(
      appBar: AppBar(title: Text(s.registerTitle)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (auth.error != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: theme.colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(auth.error!,
                        style: TextStyle(color: theme.colorScheme.error),
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 16),
                ],
                TextFormField(
                  controller: _usernameCtrl,
                  decoration: InputDecoration(
                      labelText: '${s.username} *',
                      prefixIcon: const Icon(Icons.person_outline)),
                  validator: (v) => (v == null || v.length < 3)
                      ? (s.isArabic ? 'اسم المستخدم 3 أحرف على الأقل' : 'Username must be at least 3 characters')
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: '${s.email} *',
                      prefixIcon: const Icon(Icons.email_outlined)),
                  validator: (v) =>
                      (v == null || !v.contains('@'))
                          ? (s.isArabic ? 'بريد إلكتروني غير صحيح' : 'Invalid email')
                          : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstNameCtrl,
                        decoration: InputDecoration(
                            labelText: s.isArabic ? 'الاسم الأول *' : 'First Name *'),
                        validator: (v) =>
                            (v == null || v.isEmpty) ? required : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _lastNameCtrl,
                        decoration: InputDecoration(
                            labelText: s.isArabic ? 'الاسم الأخير *' : 'Last Name *'),
                        validator: (v) =>
                            (v == null || v.isEmpty) ? required : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _gender,
                  decoration: InputDecoration(labelText: s.isArabic ? 'الجنس' : 'Gender'),
                  items: [
                    DropdownMenuItem(value: 'male', child: Text(s.isArabic ? 'ذكر' : 'Male')),
                    DropdownMenuItem(value: 'female', child: Text(s.isArabic ? 'أنثى' : 'Female')),
                  ],
                  onChanged: (v) => setState(() => _gender = v!),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _role,
                  decoration: InputDecoration(labelText: s.isArabic ? 'الدور' : 'Role'),
                  items: [
                    DropdownMenuItem(value: 'reader', child: Text(s.isArabic ? 'قارئ' : 'Reader')),
                    DropdownMenuItem(value: 'writer', child: Text(s.isArabic ? 'كاتب' : 'Writer')),
                    DropdownMenuItem(value: 'both', child: Text(s.isArabic ? 'قارئ وكاتب' : 'Reader & Writer')),
                  ],
                  onChanged: (v) => setState(() => _role = v!),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: '${s.password} *',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () => setState(() => _obscure = !_obscure),
                    ),
                  ),
                  validator: (v) => (v == null || v.length < 6)
                      ? (s.isArabic ? 'كلمة المرور 6 أحرف على الأقل' : 'Password must be at least 6 characters')
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmCtrl,
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    labelText: '${s.confirmPassword} *',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureConfirm
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                  ),
                  validator: (v) => v != _passwordCtrl.text
                      ? s.passwordsNotMatch
                      : null,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: auth.isLoading ? null : _register,
                  style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                  child: auth.isLoading
                      ? const SizedBox(
                          height: 20, width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2,
                              color: Colors.white))
                      : Text(s.register),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.go('/login'),
                  child: Text(s.haveAccount),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
