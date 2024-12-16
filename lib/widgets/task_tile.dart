import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onToggleComplete;
  final Function(String, String) onEdit;

  TaskTile({
    required this.task,
    required this.onDelete,
    required this.onToggleComplete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: task.description.isNotEmpty ? Text(task.description) : null,
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) => onToggleComplete(),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              TextEditingController titleController =
                  TextEditingController(text: task.title);
              TextEditingController descriptionController =
                  TextEditingController(text: task.description);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Edit Task'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: InputDecoration(labelText: 'Title'),
                        ),
                        TextField(
                          controller: descriptionController,
                          decoration: InputDecoration(labelText: 'Description'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          onEdit(
                              titleController.text, descriptionController.text);
                          Navigator.pop(context);
                        },
                        child: Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
