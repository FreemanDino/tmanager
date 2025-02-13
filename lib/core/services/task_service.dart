import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tmanager/core/models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TaskModel>> loadTasks(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return TaskModel(
        id: doc.id,
        title: data['title'],
        description: data['description'],
      );
    }).toList();
  }

  Future<void> saveTasks(String userId, List<TaskModel> tasks) async {
    final batch = _firestore.batch();
    final tasksCollection =
        _firestore.collection('users').doc(userId).collection('tasks');
    for (final task in tasks) {
      final docRef = tasksCollection.doc(task.id);
      batch.set(docRef, task.toMap());
    }
    await batch.commit();
  }

  Future<void> addTask(String userId, TaskModel task) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .add(task.toMap());
  }

  Future<void> updateTask(String userId, TaskModel task) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(task.id)
        .update(task.toMap());
  }

  Future<void> deleteTask(String userId, String taskId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }
}
