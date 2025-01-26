import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmanager/core/providers/main_navigation_provider.dart';
import 'package:tmanager/core/providers/task_provider.dart';
import 'package:tmanager/screens/main_app/edit_task_screen.dart';
import 'package:tmanager/screens/main_app/widgets/main_logo_text.dart';
import 'profile_page.dart';
import 'setting_page.dart';
import 'task_list_page.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final index = context.watch<MainNavigationProvider>().currentIndex;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const MainLogoText(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: IndexedStack(
          index: index,
          children: const [
            TaskListPage(),
            ProfilePage(),
            SettingPage(),
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
                      onSave: (updatedTitle, updatedDescription) {
                        context.read<TaskProvider>().addTask(
                              updatedTitle,
                              updatedDescription,
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
        onTap: (index) =>
            context.read<MainNavigationProvider>().setCurrentIndex(index),
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
