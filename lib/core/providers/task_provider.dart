import 'package:flutter/material.dart';
import 'package:tmanager/core/models/task_model.dart';
import 'package:tmanager/core/service/task_service.dart';
import 'package:uuid/uuid.dart';

class TaskProvider with ChangeNotifier {
  final TaskService _taskService = TaskService();

  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;
  List<TaskModel> _filteredTasks = [];
  List<TaskModel> get filteredTasks => _filteredTasks;

  Future<void> loadTasks() async {
    _tasks = await _taskService.loadTasks();
    _filteredTasks = _tasks;
    notifyListeners();
  }

  Future<void> saveTask(TaskModel task) async {
    if (task.id == null) {
      await addTask(task.title, task.description);
      return;
    }
    await updateTask(task);
  }

  Future<void> addTask(String title, String description) async {
    final newTask = TaskModel(
      id: const Uuid().v4(),
      title: title,
      description: description,
    );
    _tasks.add(newTask);
    await _taskService.saveTasks(_tasks);
    notifyListeners();
  }

  Future<void> updateTask(TaskModel task) async {
    final taskIndex = _tasks.indexWhere((e) => e.id == task.id);
    if (taskIndex >= 0) {
      _tasks[taskIndex] = task;
      await _taskService.saveTasks(_tasks);
      notifyListeners();
    }
  }

  Future<void> deleteTask(TaskModel task) async {
    _tasks.remove(task);
    _filteredTasks = _tasks;
    await _taskService.saveTasks(_tasks);
    notifyListeners();
  }

  List<TaskModel> searchTasks(String query) {
    return _tasks.where((task) => task.title.toLowerCase().contains(query.toLowerCase())).toList();
  }

  void filterTasks(String query) {
    if (query.isEmpty) {
      _filteredTasks = _tasks;
    } else {
      _filteredTasks = _tasks.where((task) {
        return task.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
