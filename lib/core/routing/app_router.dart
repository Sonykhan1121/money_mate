import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:money_mate/core/routing/route_names.dart';
import 'package:money_mate/features/welcome/welcome_page.dart';
import 'package:money_mate/shared_widgets/not_found_page.dart';
import '../../features/profile/presentation/views/profile_page.dart';
import 'package:money_mate/features/splash_features/splash_screen.dart';
import 'package:money_mate/features/navigation/presentation/views/navigation_page.dart';
import 'package:money_mate/features/transactions/presentation/views/transaction_details.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: kDebugMode,
    errorBuilder: (context, state) => const NotFoundPage(),
    routes: [
      GoRoute(path: RouteNames.splash, builder: (context, state) => const SplashScreen()),
      GoRoute(path: RouteNames.welcome, builder: (context, state) => WelcomePage()),
      GoRoute(
        path: RouteNames.mainNavigation,
        builder: (context, state) => const NavigationPage(),
        routes: [
          GoRoute(path: RouteNames.profileSegment, builder: (context, state) => const ProfilePage()),
          GoRoute(
            path: RouteNames.transactionSegment,
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '');
              if (id == null) {
                return NotFoundPage();
              }
              return TransactionDetails(indexOfTransactions: id);
            },
          ),
        ],
      ),
    ],
  );
}
