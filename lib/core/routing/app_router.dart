import 'package:go_router/go_router.dart';
import 'package:money_mate/core/routing/route_names.dart';
import 'package:money_mate/features/welcome/welcome_page.dart';
import '../../features/profile/presentation/views/profile_page.dart';
import 'package:money_mate/features/splash_features/splash_screen.dart';
import 'package:money_mate/features/navigation/presentation/views/navigation_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(path: RouteNames.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: RouteNames.profile, builder: (context, state) => const ProfilePage()),
      GoRoute(path: RouteNames.mainNavigation, builder: (context, state) => NavigationPage()),
      GoRoute(path: RouteNames.welcome, builder: (context, state) => WelcomePage()),
    ],
  );
}
