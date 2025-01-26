enum AppRoutes {
  root,
  login,
  register,
  verification,
  home,
  profile,
  settings,
  editTask,
}

extension AppPageExtension on AppRoutes {
  String get path => switch (this) {
        AppRoutes.root => '/',
        AppRoutes.login => '/login',
        AppRoutes.register => '/register',
        AppRoutes.verification => '/verification',
        AppRoutes.home => '/home',
        AppRoutes.profile => '/profile',
        AppRoutes.settings => '/settings',
        AppRoutes.editTask => '/editTask',
      };
}
