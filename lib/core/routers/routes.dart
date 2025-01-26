import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
        final title = state.uri.queryParameters['title'] ?? '';
        final description = state.uri.queryParameters['description'] ?? '';

        return EditTaskScreen(
          title: title,
          description: description,
          onSave: (updatedTitle, updatedDescription) {
            // Assuming you have the task id (you may need to pass this to the screen)
            const taskId =
                'task-id'; // Replace with the actual task ID if necessary

            // Update the task using the TaskProvider
            Provider.of<TaskProvider>(context, listen: false).editTask(
              taskId, // The task ID to identify which task to edit
              updatedTitle, // The updated title
              updatedDescription, // The updated description
            );

            // Optionally, you can navigate back after saving
            Navigator.pop(context);
          },
        );
      },
    ),
  ],
);
