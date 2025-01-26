import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmanager/core/models/task_model.dart';

class TaskService {
  Future<List<TaskModel>> loadTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> taskStrings = prefs.getStringList('tasks') ?? [];
    return taskStrings.map((taskString) {
      final parts = taskString.split('|');
      return TaskModel(id: parts[0], title: parts[1], description: parts[2]);
    }).toList();
  }

  Future<void> saveTasks(List<TaskModel> tasks) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> taskStrings = tasks.map((task) {
      return '${task.id}|${task.title}|${task.description}';
    }).toList();
    await prefs.setStringList('tasks', taskStrings);
  }
}
