import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/authentication/providers/auth_provider.dart';
import '../../features/authentication/screens/login_screen.dart';
import '../../features/authentication/screens/register_screen.dart';
import '../../features/educational_center/screens/home_screen.dart';
import '../../features/educational_center/screens/story_detail_screen.dart';
import '../../features/story_management/screens/read_story_screen.dart';
import '../../features/story_management/screens/add_story_screen.dart';
import '../../features/profile/screens/my_profile_screen.dart';
import '../../features/profile/screens/other_account_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/settings/screens/delete_account_screen.dart';
import '../../features/authentication/screens/forgot_password_screen.dart';

class AppRouter {
  static GoRouter router(AuthProvider authProvider) {
    return GoRouter(
      refreshListenable: authProvider,
      initialLocation: '/home',
      redirect: (BuildContext context, GoRouterState state) {
        final isLoggedIn = authProvider.isLoggedIn;
        final loc = state.matchedLocation;
        final isAuthRoute = loc == '/login' || loc == '/register' || loc == '/forgot-password';
        if (!isLoggedIn && !isAuthRoute) return '/login';
        if (isLoggedIn && isAuthRoute) return '/home';
        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/story/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
            return StoryDetailScreen(storyId: id);
          },
        ),
        GoRoute(
          path: '/read/:id',
          builder: (context, state) {
            final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
            return ReadStoryScreen(storyId: id);
          },
        ),
        GoRoute(
          path: '/add-story',
          builder: (context, state) => const AddStoryScreen(),
        ),
        GoRoute(
          path: '/profile/me',
          builder: (context, state) => const MyProfileScreen(),
        ),
        GoRoute(
          path: '/profile/:id',
          builder: (context, state) {
            final idStr = state.pathParameters['id'] ?? '';
            if (idStr == 'me') return const MyProfileScreen();
            final id = int.tryParse(idStr) ?? 0;
            return OtherAccountScreen(userId: id);
          },
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/delete-account',
          builder: (context, state) => const DeleteAccountScreen(),
        ),
        GoRoute(
          path: '/forgot-password',
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
      ],
    );
  }
}
