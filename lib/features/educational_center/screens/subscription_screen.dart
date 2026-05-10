import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../authentication/providers/auth_provider.dart';
import '../../authentication/screens/login_screen.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('الاشتراك'),
      ),
      body: authProvider.isAuthenticated
          ? _buildPricingContent(context, authProvider)
          : _buildLoginRequired(context),
    );
  }

  Widget _buildLoginRequired(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: 64,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'تسجيل الدخول مطلوب',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'يرجى تسجيل الدخول للوصول إلى خيارات الاشتراك',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              icon: const Icon(Icons.login),
              label: const Text('تسجيل الدخول'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPricingContent(BuildContext context, AuthProvider authProvider) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Icon(
            Icons.star,
            size: 64,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 24),
          Text(
            'اشتراك Premium',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'احصل على وصول كامل إلى جميع الميزات',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Features List
          _buildFeaturesList(context),
          const SizedBox(height: 32),

          // Pricing Cards
          Row(
            children: [
              Expanded(
                child: _buildPricingCard(
                  context,
                  title: 'شهري',
                  price: '\$1',
                  period: '/شهر',
                  description: 'اشتراك مرن يجدد تلقائياً',
                  isPopular: false,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPricingCard(
                  context,
                  title: 'سنوي',
                  price: '\$10',
                  period: '/سنة',
                  description: 'وفر 17% مع الاشتراك السنوي',
                  isPopular: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Current Status
          if (authProvider.isSubscribed)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'أنت مشترك حالياً! استمتع بجميع الميزات.',
                      style: TextStyle(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            FilledButton(
              onPressed: () {
                _showSubscriptionDialog(context);
              },
              child: const Text('اشترك الآن'),
            ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList(BuildContext context) {
    final features = [
      'قراءة جميع القصص بدون قيود',
      'التعليق على القصص',
      'تقييم القصص',
      'مشاهدة ملفات الكتاب',
      'متابعة الكتاب المفضلين',
      'دعم فريق العمل',
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(feature),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPricingCard(
    BuildContext context, {
    required String title,
    required String price,
    required String period,
    required String description,
    required bool isPopular,
  }) {
    final theme = Theme.of(context);

    return Card(
      elevation: isPopular ? 2 : 0,
      color: isPopular
          ? theme.colorScheme.primaryContainer
          : theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (isPopular)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'الأكثر شيوعاً',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            const SizedBox(height: 12),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Text(
                  period,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('قريباً'),
        content: const Text(
          'سيتم توصيل بوابة الدفع قريباً. شكراً لاهتمامك!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}
