import 'package:flutter/material.dart';

class TaskInput extends StatefulWidget {
  final Function(String, String) onTaskAdded;

  TaskInput({required this.onTaskAdded});

  @override
  _TaskInputState createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void clearInputFields() {
    titleController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                widget.onTaskAdded(
                    titleController.text, descriptionController.text);
                clearInputFields();
              }
            },
            child: Text('Add Task'),
          ),
        ],
      ),
    );
  }
}
