import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../data/services/api_service.dart';
import '../../../core/constants/app_constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailCtrl = TextEditingController();
  bool _loading = false;
  String? _message;
  bool _success = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailCtrl.text.trim();
    if (email.isEmpty) return;
    setState(() { _loading = true; _message = null; });

    final response = await ApiService().post(
      '/accounts/password-reset/',
      body: {'email': email},
    );

    if (!mounted) return;
    setState(() { _loading = false; });

    if (response.statusCode == 200 || response.statusCode == 204) {
      setState(() {
        _success = true;
        _message = 'تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني.';
      });
    } else {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final emailErr = data['email'];
      setState(() {
        _success = false;
        _message = (emailErr is List ? emailErr.join(', ') : null)
            ?? data['detail']?.toString()
            ?? 'حدث خطأ، حاول مرة أخرى.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نسيت كلمة المرور')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            const Text(
              'أدخل بريدك الإلكتروني وسنرسل لك رابطاً لإعادة تعيين كلمة المرور.',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'البريد الإلكتروني',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 16),
            if (_message != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _success ? Colors.green.shade50 : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _success ? Colors.green.shade200 : Colors.red.shade200,
                  ),
                ),
                child: Text(
                  _message!,
                  style: TextStyle(
                    color: _success ? Colors.green.shade800 : Colors.red.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _loading || _success ? null : _submit,
              child: _loading
                  ? const SizedBox(
                      height: 20, width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('إرسال الرابط'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => context.go('/login'),
              child: const Text('العودة إلى تسجيل الدخول'),
            ),
          ],
        ),
      ),
    );
  }
}
