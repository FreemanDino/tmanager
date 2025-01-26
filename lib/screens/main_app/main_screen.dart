import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmanager/screens/main_app/widgets/main_logo_text.dart';
import 'edit_task_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  List<Map<String, String>> tasks = [];
  List<Map<String, String>> filteredTasks = [];
  bool isGridView = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
    searchController.addListener(_filterTasks);
  }

  Future<void> _loadTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> taskStrings = prefs.getStringList('tasks') ?? [];
    setState(() {
      tasks = taskStrings.map((taskString) {
        final parts = taskString.split('|');
        return {'title': parts[0], 'description': parts[1]};
      }).toList();
      filteredTasks = tasks;
    });
  }

  void _filterTasks() {
    setState(() {
      filteredTasks = tasks.where((task) {
        return task['title']!.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();
    });
  }

  Future<void> _saveTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> taskStrings = tasks.map((task) {
      return '${task['title']}|${task['description']}';
    }).toList();
    await prefs.setStringList('tasks', taskStrings);
  }

  Future<void> _addTask(String title, String description) async {
    if (title.isNotEmpty) {
      setState(() {
        tasks.add({'title': title, 'description': description});
      });
      await _saveTasks();
    }
  }

  Future<void> _editTask(int index, String newTitle, String newDescription) async {
    if (newTitle.isNotEmpty) {
      setState(() {
        tasks[index] = {'title': newTitle, 'description': newDescription};
      });
      await _saveTasks();
    }
  }

  Future<void> _deleteTask(int index) async {
    setState(() {
      tasks.removeAt(index);
    });
    await _saveTasks();
  }

  void _showAddTaskDialog() {
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
              _addTask(title, description);
              Navigator.pop(context);
            },
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.resolveWith<Color>(
                (states) {
                  if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
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
              _addTask(title, description);
              Navigator.pop(context);
            },
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.resolveWith<Color>(
                (states) {
                  if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
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

  void _showTaskOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white),
              title: const Text('Переименовать', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _showEditTaskDialog(index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.white),
              title: const Text('Удалить', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _deleteTask(index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.open_in_new, color: Colors.white),
              title: const Text('Открыть', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(
                      title: tasks[index]['title'] ?? '',
                      description: tasks[index]['description'] ?? '',
                      onSave: (updatedTitle, updatedDescription) {
                        _editTask(index, updatedTitle, updatedDescription);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditTaskDialog(int index) {
    String updatedTitle = tasks[index]['title']!;
    final String updatedDescription = tasks[index]['description']!;

    final TextEditingController titleController = TextEditingController(text: updatedTitle);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF141414),
        title: const Text(
          'Переименовать задачу',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.normal,
          ),
        ),
        content: Column(
          children: [
            TextField(
              controller: titleController,
              onChanged: (value) {
                updatedTitle = value;
              },
              decoration: const InputDecoration(
                labelText: 'Название задачи',
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
                fontWeight: FontWeight.normal,
              ),
              cursorColor: Colors.white,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
                  return Colors.grey;
                }
                return Colors.transparent;
              }),
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
              _editTask(index, updatedTitle, updatedDescription);
              Navigator.pop(context);
            },
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.hovered) || states.contains(WidgetState.pressed)) {
                  return Colors.grey;
                }
                return Colors.transparent;
              }),
            ),
            child: const Text(
              'Сохранить',
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

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: <Widget>[
            TextField(
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                labelText: 'Поиск задачи',
                labelStyle: const TextStyle(color: Colors.white),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
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
            Expanded(
              child: isGridView
                  ? GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _showTaskOptions(index),
                          child: Card(
                            color: Colors.grey[800],
                            child: Center(
                              child: Text(
                                filteredTasks[index]['title'] ?? 'Без названия',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _showTaskOptions(index),
                          child: ListTile(
                            title: Text(
                              filteredTasks[index]['title'] ?? 'Без названия',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
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
