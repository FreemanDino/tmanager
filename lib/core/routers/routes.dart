import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tmanager/core/models/task_model.dart';
import 'package:tmanager/core/providers/task_provider.dart';
import 'package:tmanager/screens/authentication/first_login_screen.dart';
import 'package:tmanager/screens/main_app/edit_task_screen.dart';
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
      builder: (context, state) {
        // final title = state.uri.queryParameters['title'] ?? '';
        // final description = state.uri.queryParameters['description'] ?? '';
        final task = state.uri.queryParameters['title'] == null
            ? TaskModel.empty()
            : TaskModel.fromMap(jsonDecode(state.uri.queryParameters['title']!) as Map<String, dynamic>);
        return EditTaskScreen(
          task: task,
          onSave: (updatedTitle, updatedDescription) {
            Provider.of<TaskProvider>(context, listen: false).updateTask(task);
            Navigator.pop(context);
          },
        );
      },
    ),
  ],
);
