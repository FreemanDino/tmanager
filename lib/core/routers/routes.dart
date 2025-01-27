import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tmanager/core/models/task_model.dart';
import 'package:tmanager/core/providers/task_provider.dart';
import 'package:tmanager/screens/user_interface/edit_task_screen.dart';
import 'package:tmanager/screens/user_interface/profile_screen.dart';
import 'package:tmanager/screens/start/login_screen.dart';
import '../../screens/user_interface/home_screen.dart';
import '../../screens/start/register_screen.dart';
import '../../screens/start/splash_screen.dart';
import '../../screens/start/verify_screen.dart';
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
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile.path,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.settings.path,
      builder: (context, state) => const SizedBox(),
    ),
    GoRoute(
      path: AppRoutes.editTask.path,
      builder: (context, state) {
        final task = state.uri.queryParameters['title'] == null
            ? TaskModel.empty()
            : TaskModel.fromMap(
                jsonDecode(state.uri.queryParameters['title']!)
                    as Map<String, dynamic>,
              );
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
