import 'package:flutter/material.dart';
import 'package:tmanager/core/models/task_model.dart';
import 'package:tmanager/core/service/task_service.dart';

class TaskProvider with ChangeNotifier {
  final TaskService _taskService = TaskService();
  
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;
  List<TaskModel> _filteredTasks = [];
  List<TaskModel> get filteredTasks => _filteredTasks;

  Future<void> loadTasks() async {
    _tasks = await _taskService.loadTasks();
    notifyListeners();
  }

  Future<void> addTask(String title, String description) async {
    final newTask = TaskModel(
      id: DateTime.now().toIso8601String(),
      title: title,
      description: description,
    );
    _tasks.add(newTask);
    await _taskService.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> editTask(String id, String title, String description) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      _tasks[taskIndex] = TaskModel(id: id, title: title, description: description);
      await _taskService.saveTasks(_tasks);
      notifyListeners();
    }
  }

  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((task) => task.id == id);
    await _taskService.saveTasks(_tasks);
    notifyListeners();
  }

  List<TaskModel> searchTasks(String query) {
    return _tasks
        .where((task) => task.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

}
