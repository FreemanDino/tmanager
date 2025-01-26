// Created Date: January 26th 2025
// Author: Oleg Khmara

import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  List<Map<String, String>> _tasks = [];
  List<Map<String, String>> get tasks => _tasks;
  List<Map<String, String>> _filteredTasks = [];
  List<Map<String, String>> get filteredTasks => _filteredTasks;
}
