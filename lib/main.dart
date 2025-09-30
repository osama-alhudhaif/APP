import 'package:flutter/material.dart';

/*
  قائمة المهام المستقبلية للتطبيق:
  1- إضافة app bar وفي الجهة اليمنى قائمة (Drawer) تحتوي على: (الإعدادات، الحساب، قائمة القراءة لاحقًا).
  2- إضافة أيقونة في الجهة اليسرى للتصفية (Filter).
  3- إضافة ميزة التحديث التلقائي عند الحفظ (Hot Reload).
  4- إضافة الوضع المظلم (Dark Mode).
  5- ربط التطبيق مع API.
  6- إضافة تشفير للبيانات.
  7- تعريف كل زر باسم مخصص للوصولية (Accessibility).
  8- إضافة أزرار التفاعل (مثل الإعجاب والمشاركة).
  9- إضافة زر لعرض حسابات المشروع أو المستخدم.
  10- إضافة التنقل بين الصفحات (Navigation).
*/

// نقطة بداية تشغيل التطبيق
void main() {
  //  runApp تستدعي الويدجت الجذر للتطبيق وهو MyApp
  runApp(const MyApp());
}

// الويدجت الرئيسي للتطبيق (StatelessWidget)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp هو الويدجت الأساسي الذي يوفر ميزات التصميم الماتيريال
    return MaterialApp(
      // لإزالة شريط "Debug" الذي يظهر في الزاوية
      debugShowCheckedModeBanner: false,
      // home يحدد الواجهة الرئيسية التي ستظهر عند تشغيل التطبيق
      home: Scaffold(
        // AppBar هو الشريط العلوي في التطبيق
        appBar: AppBar(
          // لون خلفية الشريط العلوي
          backgroundColor: Colors.black,
          // عنوان التطبيق الذي يظهر في الشريط العلوي
          title: const Text(
            "عوالمنا",
            // تحديد نمط الخط ليكون باللون الأبيض ليسهل قراءته
            style: TextStyle(color: Colors.white),
          ),
          // لجعل العنوان في منتصف الشريط
          centerTitle: true,
          // الأيقونات التي تظهر في الجهة اليمنى من الشريط
          actions: [
            // IconButton لإنشاء زر يحتوي على أيقونة
            IconButton(
              onPressed: () {
                // هنا تضع الكود الذي يتم تنفيذه عند الضغط على أيقونة البحث
              },
              icon: const Icon(Icons.search, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                // كود الضغط على أيقونة الإعدادات
              },
              icon: const Icon(Icons.settings, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                // كود الضغط على أيقونة الحساب
              },
              icon: const Icon(Icons.account_circle, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                // كود الضغط على أيقونة القائمة
              },
              icon: const Icon(Icons.menu, color: Colors.white),
            ),
          ],
        ),
        // body هو المحتوى الرئيسي للصفحة
        body: const SafeArea(
          // SafeArea تضمن عدم تداخل المحتوى مع حواف الشاشة وأشرطة النظام
          child: Center(
            
          ),
        ),
      ),
    );
  }
}
