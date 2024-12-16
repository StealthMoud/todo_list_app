import 'package:flutter/material.dart';
import '../widgets/task_tile.dart';
import '../models/task.dart';
import '../widgets/task_input.dart';
import '../widgets/task_search_delegate.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  HomeScreen({required this.isDarkMode, required this.toggleTheme});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  String currentFilter = 'All';

  void addTask(String title, String description) {
    setState(() {
      tasks.add(Task(title: title, description: description));
    });
  }

  void editTask(int index, String newTitle, String newDescription) {
    setState(() {
      tasks[index].title = newTitle;
      tasks[index].description = newDescription;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].toggleCompletion();
    });
  }

  List<Task> getFilteredTasks() {
    if (currentFilter == 'All') return tasks;
    if (currentFilter == 'Completed')
      return tasks.where((task) => task.isCompleted).toList();
    if (currentFilter == 'Pending')
      return tasks.where((task) => !task.isCompleted).toList();
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    List<Task> filteredTasks = getFilteredTasks();

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          // Search icon at the far right (search bar)
          IconButton(
            icon: Icon(Icons.search), // This is the search icon
            onPressed: () async {
              final result = await showSearch(
                  context: context, delegate: TaskSearchDelegate(tasks));
              // Handle result if needed
            },
          ),
          // Dark/Light mode icon
          IconButton(
            icon: Icon(
                Icons.brightness_6), // This is the dark/light mode toggle icon
            onPressed: widget.toggleTheme,
          ),
          // Three dots (more options) icon for filter
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                currentFilter = value;
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(value: 'All', child: Text('All')),
              PopupMenuItem(value: 'Completed', child: Text('Completed')),
              PopupMenuItem(value: 'Pending', child: Text('Pending')),
            ],
            icon: Icon(Icons.more_vert), // This is the three dots (menu) icon
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                return TaskTile(
                  task: filteredTasks[index],
                  onToggleComplete: () => toggleTaskCompletion(index),
                  onDelete: () => deleteTask(index),
                  onEdit: (newTitle, newDescription) =>
                      editTask(index, newTitle, newDescription),
                );
              },
            ),
          ),
          TaskInput(onTaskAdded: addTask),
        ],
      ),
    );
  }
}
