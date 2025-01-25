import 'package:go_router/go_router.dart';
import '../authentication/first_login_screen.dart';
import '../authentication/registration_screen.dart';
import '../authentication/splash_screen.dart';
import '../authentication/verification_screen.dart';
import '../main_app/main_page_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const FirstLoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegistrationScreen(),
    ),
    GoRoute(
      path: '/verify',
      builder: (context, state) => const VerificationScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainPageScreen(),
    ),
  ],
);
