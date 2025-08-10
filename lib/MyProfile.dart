import 'package:flutter/material.dart';
import 'pages.dart';

void main() {
  runApp(const MyApp()); // تم تغيير اسم الكلاس هنا
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyProfile(), // هنا نضيف MyProfile كالصفحة الرئيسية
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: const Center(
          // هنا اسم المستخدم

          // هنا اليوزر

          // هنا الايميل

          // هنا اخر تغير لكمة السر

          // التحقق بخطوطين

          // هنا القصص المنشورة مع التقيم
          ),
    );
  }
}
