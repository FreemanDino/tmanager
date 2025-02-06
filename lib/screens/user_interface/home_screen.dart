import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tmanager/core/models/task_model.dart';
import 'package:tmanager/core/providers/navigation_provider.dart';
import 'package:tmanager/core/providers/task_provider.dart';
import 'package:tmanager/core/routers/app_routers.dart';
import 'package:tmanager/screens/user_interface/edit_task_screen.dart';
import 'package:tmanager/screens/user_interface/widgets/home_logo_text.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
// import 'task_list_screen.dart';

String? getCurrentUserId() {
  final user = FirebaseAuth.instance.currentUser;
  return user?.uid;
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final index = context.watch<MainNavigationProvider>().currentIndex;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const HomeLogoText(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: IndexedStack(
          index: index,
          children: const [
            // TaskListScreen(),
            ProfileScreen(),
            SettingsScreen(),
          ],
        ),
      ),
      floatingActionButton: index != 0
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(
                      task: null,
                      isNew: true,
                      onSave:
                          (String taskId, String title, String description) {
                        final newTask = TaskModel(
                          id: taskId,
                          title: title,
                          description: description,
                        );
                        Provider.of<TaskProvider>(context, listen: false)
                            .addTask(
                          newTask.title,
                          newTask.description,
                        );
                      },
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add, color: Colors.black),
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: index,
        onTap: (index) {
          context.read<MainNavigationProvider>().setCurrentIndex(index);
          switch (index) {
            case 0:
              break;
            case 1:
              context.go(AppRoutes.profile.path);
              break;
            case 2:
              context.go(AppRoutes.settings.path);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }
}
