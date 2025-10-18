import 'package:flutter/material.dart';
import 'package:todolist/models/task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [
    Task(name: 'Setup Android Studio', completed: true),
    Task(name: 'Learn Flutter', completed: true),
    Task(name: 'Build a Flutter App', completed: false),
  ];

  TextEditingController taskNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To do List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks[index];

          return ListTile(
            leading: Checkbox(
              value: task.completed,
              onChanged: (value) {
                Task updatedTask = Task(
                  name: task.name,
                  completed: value ?? false,
                );

                setState(() {
                  tasks[index] = updatedTask;
                });
              },
            ),
            title: Text(task.name),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  tasks.removeAt(index);
                });
              },
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add a new task'),
                content: TextField(controller: taskNameController),
                actions: [
                  TextButton(
                    onPressed: () {
                      taskNameController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String taskName = taskNameController.text.trim();

                      if (taskName.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter a task name')),
                        );
                        return;
                      }

                      Task task = Task(name: taskName, completed: false);
                      setState(() {
                        tasks.add(task);
                      });

                      taskNameController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
