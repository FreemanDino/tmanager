import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tmanager/core/models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TaskModel>> loadTasks() async {
    final snapshot = await _firestore.collection('tasks').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return TaskModel(
        id: doc.id,
        title: data['title'],
        description: data['description'],
      );
    }).toList();
  }

  Future<void> saveTasks(List<TaskModel> tasks) async {
    final batch = _firestore.batch();
    final tasksCollection = _firestore.collection('tasks');

    for (final task in tasks) {
      final docRef = tasksCollection.doc(task.id);
      batch.set(docRef, task.toMap());
    }

    await batch.commit();
  }

  Future<void> addTask(TaskModel task) async {
    await _firestore.collection('tasks').add(task.toMap());
  }

  Future<void> updateTask(TaskModel task) async {
    await _firestore.collection('tasks').doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }
}
