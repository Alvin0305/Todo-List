import 'package:hive/hive.dart';
import 'package:todolist/models/task.dart';

final Box<Task> tasksBox = Hive.box('tasks');

List<Task> getTasks() {
  return tasksBox.values.toList();
}

Future<void> addTask(Task task) async {
  await tasksBox.add(task);
}

Future<void> updateTask(int index, Task task) async {
  await tasksBox.putAt(index, task);
}

Future<void> deleteTask(int index) async {
  await tasksBox.deleteAt(index);
}
