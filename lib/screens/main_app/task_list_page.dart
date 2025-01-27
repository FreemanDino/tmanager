import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmanager/core/models/task_model.dart';
import 'package:tmanager/core/providers/task_provider.dart';
import 'package:tmanager/screens/main_app/edit_task_screen.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  bool isGridView = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final taskProvider = Provider.of<TaskProvider>(context, listen: false)
      ..loadTasks();
    searchController.addListener(() {
      taskProvider.filterTasks(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<TaskProvider>().filteredTasks;

    return Column(
      children: [
        ColoredBox(
          color: Colors.black,
          child: Column(
            children: [
              TextField(
                controller: searchController,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Поиск задачи',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide:
                        const BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.view_module, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        isGridView = true;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.view_list, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        isGridView = false;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: isGridView
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final TaskModel task = tasks[index];
                    return Material(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          // Реализация открытия существующей задачи
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditTaskScreen(
                                task: task, // Pass the existing task
                                onSave: (updatedTitle, updatedDescription) {
                                  // Update the task in the provider
                                  final updatedTask = TaskModel(
                                    id: task.id, // Keep the same ID
                                    title: updatedTitle,
                                    description: updatedDescription,
                                  );
                                  Provider.of<TaskProvider>(
                                    context,
                                    listen: false,
                                  ).updateTask(updatedTask);
                                },
                              ),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            tasks[index].title,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : ListView.separated(
                  itemCount: tasks.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 4),
                  itemBuilder: (context, index) {
                    final TaskModel task = tasks[index];
                    return ListTile(
                      onTap: () {
                        // Реализация открытия существующей задачи
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTaskScreen(
                              task: task, // Pass the existing task
                              onSave: (updatedTitle, updatedDescription) {
                                // Update the task in the provider
                                final updatedTask = TaskModel(
                                  id: task.id, // Keep the same ID
                                  title: updatedTitle,
                                  description: updatedDescription,
                                );
                                Provider.of<TaskProvider>(
                                  context,
                                  listen: false,
                                ).updateTask(updatedTask);
                              },
                            ),
                          ),
                        );
                      },
                      tileColor: const Color(0xFF141414),
                      title: Text(
                        tasks[index].title,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Provider.of<TaskProvider>(context, listen: false)
                              .deleteTask(task);
                        },
                        icon: const Icon(Icons.delete, color: Colors.white),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
