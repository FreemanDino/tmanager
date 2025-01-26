import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tmanager/screens/authentication/first_login_screen.dart';
import 'package:tmanager/screens/main_app/edit_task_page.dart';
import 'package:tmanager/screens/main_app/profile_page.dart';
import '../../screens/authentication/registration_screen.dart';
import '../../screens/authentication/verification_screen.dart';
import '../../screens/main_app/main_screen.dart';
import '../../splash_screen.dart';
import 'app_routers.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: AppRoutes.root.path,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.login.path,
      builder: (context, state) => const FirstLoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register.path,
      builder: (context, state) => const RegistrationScreen(),
    ),
    GoRoute(
      path: AppRoutes.verification.path,
      builder: (context, state) => const VerificationScreen(),
    ),
    GoRoute(
      path: AppRoutes.home.path,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile.path,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: AppRoutes.settings.path,
      builder: (context, state) => const SizedBox(),
    ),
    GoRoute(
      path: AppRoutes.editTask.path,
      builder: (context, state) => const EditTaskPage(title: '', description: ''),
    ),
  ],
);
