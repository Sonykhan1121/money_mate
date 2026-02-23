class RouteNames {
  RouteNames._();

  // Base routes
  static const String splash         = '/';
  static const String welcome        = '/welcome';
  static const String mainNavigation = '/main_navigation';

  // Full paths for navigation
  static const String profile            = '/main_navigation/profile';
  static const String transactionSegment = 'transaction/:id';
  static const String profileSegment     = 'profile';

  // Dynamic
  static String transaction(int id) => '/main_navigation/transaction/$id';
}