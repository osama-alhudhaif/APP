import 'package:flutter/material.dart';
import 'pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        brightness: Brightness.light,
        // primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200], // خلفية بلون خفيف
        appBarTheme: AppBarTheme(
            // backgroundColor: Colors.grey[700], // لون أقل سطوعًا لشريط التطبيق
            ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87), // نص بلون أقل سطوعًا
          bodyMedium: TextStyle(color: Colors.black54), // نص خافت
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'البريد الإلكتروني',
                  labelStyle: TextStyle(
                      color: Colors.grey[700]), // لون النص داخل الحقول
                ),
              ),
              const SizedBox(height: 16), // مسافة بين الحقول
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'كلمة المرور',
                  labelStyle: TextStyle(
                      color: Colors.grey[700]), // لون النص داخل الحقول
                ),
                obscureText: true, // إخفاء النص لكلمات المرور
              ),
              const SizedBox(height: 16), // مسافة بين الحقول
              ElevatedButton(
                onPressed: () {
                  // ignore: avoid_print
                  print('Email: ${_emailController.text}');
                  // ignore: avoid_print
                  print('Password: ${_passwordController.text}');
                },
                // ignore: sort_child_properties_last
                child: const Text('تسجيل الدخول'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.lightBlue[300], // زر بلون أفتح
                ),
              ),
              TextButton(
                onPressed: () {
                  // يمكن إضافة منطق إنشاء حساب جديد هنا
                },
                child: const Text(
                  'إنشاء حساب جديد',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
