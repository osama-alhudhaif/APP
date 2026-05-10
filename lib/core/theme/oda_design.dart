import 'package:flutter/material.dart';

/// 🎨 ألوان هوية أودا
class OdaColors {
  // الألوان الأساسية
  static const Color primary = Color(0xFFE67E50); // لون مرجاني دافئ
  static const Color primaryLight = Color(0xFFFFA07A);
  static const Color primaryDark = Color(0xFFC85A3F);

  // ألوان الخلفية
  static const Color background = Color(0xFFFDF8F5); // بيج فاتح دافئ
  static const Color backgroundDark = Color(0xFF2D3436);
  static const Color surface = Colors.white;
  static const Color surfaceDark = Color(0xFF3D4749);

  // ألوان النصوص
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);
  static const Color textLight = Color(0xFFB2BEC3);

  // ألوان الحالات
  static const Color success = Color(0xFF00B894);
  static const Color error = Color(0xFFFF6B6B);
  static const Color warning = Color(0xFFFDCB6E);
  static const Color info = Color(0xFF74B9FF);

  // ألوان إضافية
  static const Color shadow = Color(0x1A2D3436);
  static const Color divider = Color(0xFFE8E8E8);
  static const Color inputFill = Color(0xFFF8F9FA);
}

/// 📐 التباعد والأحجام
class OdaSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  static const double radius = 16;
  static const double radiusLarge = 24;
  static const double buttonHeight = 56;
  static const double inputHeight = 56;
}

/// ✨ التأثيرات والظلال
class OdaShadows {
  static BoxShadow get small => BoxShadow(
        color: OdaColors.shadow,
        blurRadius: 8,
        offset: const Offset(0, 2),
      );

  static BoxShadow get medium => BoxShadow(
        color: OdaColors.shadow,
        blurRadius: 16,
        offset: const Offset(0, 4),
      );

  static BoxShadow get large => BoxShadow(
        color: OdaColors.shadow,
        blurRadius: 24,
        offset: const Offset(0, 8),
      );

  static List<BoxShadow> get card => [medium];
  static List<BoxShadow> get elevated => [large];
  static List<BoxShadow> get input => [small];
}

/// 🎨 التدرجات اللونية
class OdaGradients {
  static const LinearGradient primary = LinearGradient(
    colors: [OdaColors.primary, OdaColors.primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient background = LinearGradient(
    colors: [Color(0xFFFDF8F5), Color(0xFFFFF5F0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient surface = LinearGradient(
    colors: [Colors.white, Color(0xFFFAFAFA)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// 📝 أنماط النصوص
class OdaTextStyles {
  static const String fontFamily = 'Cairo';

  static TextStyle get heading1 => const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: OdaColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get heading2 => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: OdaColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get heading3 => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: OdaColors.textPrimary,
        height: 1.4,
      );

  static TextStyle get body => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: OdaColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: OdaColors.textSecondary,
        height: 1.5,
      );

  static TextStyle get label => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: OdaColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get button => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.4,
      );
}

/// 🎯 عناصر واجهة المستخدم المُعاد استخدامها
class OdaWidgets {
  /// حقل إدخال مُحسّن
  static Widget inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    Widget? suffixIcon,
    VoidCallback? onTap,
    bool readOnly = false,
    int? maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(OdaSpacing.radius),
        boxShadow: OdaShadows.input,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        onTap: onTap,
        readOnly: readOnly,
        maxLines: maxLines,
        style: OdaTextStyles.body,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: OdaTextStyles.label,
          prefixIcon: Icon(icon, color: OdaColors.primary, size: 22),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: OdaColors.inputFill,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(OdaSpacing.radius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(OdaSpacing.radius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(OdaSpacing.radius),
            borderSide: const BorderSide(color: OdaColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(OdaSpacing.radius),
            borderSide: const BorderSide(color: OdaColors.error, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(OdaSpacing.radius),
            borderSide: const BorderSide(color: OdaColors.error, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: OdaSpacing.md,
            vertical: OdaSpacing.md,
          ),
        ),
      ),
    );
  }

  /// زر رئيسي مُحسّن
  static Widget primaryButton({
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    Widget? icon,
  }) {
    return Container(
      height: OdaSpacing.buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(OdaSpacing.radius),
        gradient: isLoading ? null : OdaGradients.primary,
        boxShadow: isLoading ? null : [OdaShadows.small],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isLoading ? OdaColors.textLight : Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(OdaSpacing.radius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: OdaSpacing.lg),
        ),
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    icon,
                    const SizedBox(width: OdaSpacing.sm),
                  ],
                  Text(text, style: OdaTextStyles.button),
                ],
              ),
      ),
    );
  }

  /// زر ثانوي (شفاف مع إطار)
  static Widget secondaryButton({
    required String text,
    required VoidCallback onPressed,
    Widget? icon,
  }) {
    return Container(
      height: OdaSpacing.buttonHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(OdaSpacing.radius),
        border: Border.all(color: OdaColors.primary, width: 2),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: OdaColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(OdaSpacing.radius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: OdaSpacing.lg),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon,
              const SizedBox(width: OdaSpacing.sm),
            ],
            Text(
              text,
              style: OdaTextStyles.button.copyWith(color: OdaColors.primary),
            ),
          ],
        ),
      ),
    );
  }

  /// رسالة خطأ
  static Widget errorMessage(String message) {
    return Container(
      padding: const EdgeInsets.all(OdaSpacing.md),
      decoration: BoxDecoration(
        color: OdaColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(OdaSpacing.radius),
        border: Border.all(color: OdaColors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: OdaColors.error, size: 20),
          const SizedBox(width: OdaSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: OdaTextStyles.bodySmall.copyWith(color: OdaColors.error),
            ),
          ),
        ],
      ),
    );
  }

  /// بطاقة محتوى
  static Widget card({
    required Widget child,
    EdgeInsets? padding,
  }) {
    return Container(
      padding: padding ?? const EdgeInsets.all(OdaSpacing.lg),
      decoration: BoxDecoration(
        color: OdaColors.surface,
        borderRadius: BorderRadius.circular(OdaSpacing.radiusLarge),
        boxShadow: OdaShadows.card,
      ),
      child: child,
    );
  }

  /// شعار أودا
  static Widget logo({double size = 80}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: OdaGradients.primary,
        borderRadius: BorderRadius.circular(size * 0.3),
        boxShadow: [OdaShadows.medium],
      ),
      child: Icon(
        Icons.menu_book_rounded,
        size: size * 0.5,
        color: Colors.white,
      ),
    );
  }
}
