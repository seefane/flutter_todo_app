import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/models/task_model.dart';
import 'package:flutter_todo_app/api/services.dart';
import 'package:flutter_todo_app/widgets/first_screen.dart';

import 'models/edit_task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get gettasks => _tasks;

  Future<List<Task>> fetchTasks() async {
    _tasks = await TaskApi().fetchtasks();
    notifyListeners();
    return _tasks;
  }

  Future<TaskEdit> addTask(
      String title, String description, String dueDate, String status) async {
    var task = await TaskApi().createTask(title, description, dueDate, status);
    fetchTasks();
    notifyListeners();
    return task;
  }

  Future<TaskEdit> fetchtask(String id) async {
    var task = await TaskApi().fetchTask(id);
    fetchTasks();
    return task;
  }

  Future<TaskEdit> updatetask(String taskid, String title, String description,
      String duedate, String status) async {
    var task =
        await TaskApi().updateTask(taskid, title, description, duedate, status);
    fetchTasks();
    return task;
  }

  void delTask(String taskid) async {
    var task = await TaskApi().deleteTask(taskid);
    fetchTasks();
    notifyListeners();
  }
}
