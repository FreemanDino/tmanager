import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tmanager/core/providers/main_navigation_provider.dart';
import 'package:tmanager/core/providers/task_provider.dart';
import 'package:tmanager/core/routers/app_routers.dart';
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
        padding: const EdgeInsets.all(16.0),
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
              onPressed: () => _showAddTaskDialog(context),
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

  void _showAddTaskDialog(BuildContext context) {
    String title = '';
    String description = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF141414),
        title: const Text(
          'Добавить задачу',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.normal,
          ),
        ),
        content: TextField(
          onChanged: (value) {
            title = value;
            description = value;
          },
          decoration: const InputDecoration(
            labelText: 'Введите название задачи',
            labelStyle: TextStyle(
              color: Colors.grey,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.normal,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
          ),
          cursorColor: Colors.white,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<TaskProvider>(context, listen: false)
                  .addTask(title, description);
              Navigator.pop(context);
            },
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.resolveWith<Color>(
                (states) {
                  if (states.contains(WidgetState.hovered) ||
                      states.contains(WidgetState.pressed)) {
                    return Colors.grey;
                  }
                  return Colors.transparent;
                },
              ),
            ),
            child: const Text(
              'Отмена',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.go(
                '${AppRoutes.editTask.path}?title=$title',
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTaskScreen(
                    title: title, // Pass the current title here
                    description:
                        description, // Pass the current description here
                    onSave: (updatedTitle, updatedDescription) {
                      Provider.of<TaskProvider>(context, listen: false)
                          .editTask(
                        'task-id',
                        updatedTitle,
                        updatedDescription,
                      );
                    },
                  ),
                ),
              );
              Provider.of<TaskProvider>(context, listen: false)
                  .addTask(title, description);
              Navigator.pop(context);
            },
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.resolveWith<Color>(
                (states) {
                  if (states.contains(WidgetState.hovered) ||
                      states.contains(WidgetState.pressed)) {
                    return Colors.grey;
                  }
                  return Colors.transparent;
                },
              ),
            ),
            child: const Text(
              'Добавить',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
