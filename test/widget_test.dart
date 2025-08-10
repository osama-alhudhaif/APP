// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:awallimna/main.dart';

void main() {
  // اختبار عداد يبدأ من 0 ثم يزداد إلى 1 عند الضغط على زر +
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp() as Widget);

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  // اختبار عرض القصص في الصفحة الرئيسية
  testWidgets('Displays story on the main page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp() as Widget);

    // تحقق من وجود عنوان قصة معيّن
    expect(find.text('قصة موجودة'), findsOneWidget);
    expect(find.text('قصة غير موجودة'), findsNothing);
  });

  // اختبار زر إضافة قصة جديدة
  testWidgets('Add story button navigates to add story screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp() as Widget);

    // اضغط على زر إضافة قصة
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // تحقق من ظهور شاشة إضافة القصة
    expect(find.text('إضافة قصة جديدة'), findsOneWidget);
  });

  // اختبار التسجيل أو تسجيل الدخول
  testWidgets('Login screen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp() as Widget);

    // تحقق من وجود الحقول الخاصة بالبريد وكلمة المرور
    expect(find.text('البريد الإلكتروني'), findsOneWidget);
    expect(find.text('كلمة المرور'), findsOneWidget);
  });

  // اختبار عرض تفاصيل القصة
  testWidgets('Story details page opens on tap', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp() as Widget);

    // اضغط على قصة محددة
    await tester.tap(find.text('قصة مميزة'));
    await tester.pumpAndSettle();

    // تحقق من وجود عنوان القصة في صفحة التفاصيل
    expect(find.text('تفاصيل قصة مميزة'), findsOneWidget);
  });
}

class MyApp {
  const MyApp();
}
