import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const LoadingApp());
}

/// تطبيق تجريبي لأنميشن "الكتاب الكامل"
class LoadingApp extends StatelessWidget {
  const LoadingApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔄 غيّر اللغة حسب الاتجاه المطلوب
    // 'ar' = يفتح من اليمين  |  'en' = يفتح من اليسار
    const languageCode = 'ar';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingPage(languageCode: languageCode),
    );
  }
}

/// صفحة التحميل الكاملة
class LoadingPage extends StatelessWidget {
  final String languageCode;

  const LoadingPage({super.key, required this.languageCode});

  @override
  Widget build(BuildContext context) {
    final isArabic = languageCode == 'ar';
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // أنميشن الغلاف يغطي الشاشة بالكامل
          LoadingBook(isArabic: isArabic),

          // النص بالأسفل
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Text(
                isArabic ? 'جارٍ فتح القصة...' : 'Opening your story...',
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF6B4EFF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// أنميشن الكتاب: الغلاف يغطي الشاشة ويفتح من أحد الأطراف
class LoadingBook extends StatefulWidget {
  final bool isArabic;
  const LoadingBook({super.key, required this.isArabic});

  @override
  State<LoadingBook> createState() => _LoadingBookState();
}

class _LoadingBookState extends State<LoadingBook>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    const bookColor = Color(0xFF6B4EFF);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // بين 0 و π/1.2 تقريباً (فتح من الطرف)
        final angle = _animation.value * (math.pi / 1.2);
        final alignment =
            widget.isArabic ? Alignment.centerRight : Alignment.centerLeft;
        final rotateY = widget.isArabic ? -angle : angle;

        return Stack(
          children: [
            // الغلاف المتحرك (يغطي الشاشة من أحد الأطراف)
            Align(
              alignment: alignment,
              child: Transform(
                alignment: alignment,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(rotateY),
                child: Container(
                  width: screen.width,
                  height: screen.height,
                  color: bookColor,
                ),
              ),
            ),
            // ظل خفيف يعطي عمق عند الفتح
            Align(
              alignment: alignment,
              child: Container(
                width: screen.width,
                height: screen.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: alignment,
                    end: widget.isArabic
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    colors: [
                      // ignore: deprecated_member_use
                      Colors.black.withOpacity(0.2 * (1 - _animation.value)),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
