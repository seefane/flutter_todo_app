import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/models/edit_task.dart';
import 'package:flutter_todo_app/api/models/task_model.dart';

import 'package:flutter_todo_app/api/services.dart';
import 'package:flutter_todo_app/api/task_provider.dart';
import 'package:flutter_todo_app/widgets/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'date_time_picker.dart';
import 'first_screen.dart';

class TaskForm extends StatefulWidget {
  final String taskId;

  const TaskForm({
    Key? key,
    required this.taskId,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _TaskFormState createState() => _TaskFormState(taskId);
}

class _TaskFormState extends State<TaskForm> {
  String taskId;
  String title = 'Create Task';
  _TaskFormState(this.taskId);

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  String due_date_for_writing = "";
  String _status = "Pending";
  String _picked_duedate = "Select the due date and time";

  TaskProvider? notifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notifier = Provider.of<TaskProvider>(context);
    if (this.notifier != notifier) {
      this.notifier = notifier;
      Future.microtask(() => notifier.fetchTasks());
    }

    var _tasks = notifier.gettasks;

    if (taskId != "create") {
      title = "Edit Task";
      _titleController.text = _tasks[int.parse(taskId)].title;
      _descriptionController.text = _tasks[int.parse(taskId)].description;
      _status = _tasks[int.parse(taskId)].status;
      _picked_duedate = formatDateTime(_tasks[int.parse(taskId)].due_date);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _tasks = notifier!.gettasks;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text(title)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              Container(height: 8),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              Container(height: 8),

              Container(
                child: DateTimePicker(
                  picked_date_time: _picked_duedate,
                ),
              ),

              Container(height: 8),
              DropdownButton(
                value: _status,

                // ignore: prefer_const_literals_to_create_immutables
                items: [
                  const DropdownMenuItem(
                    child: Text("Pending"),
                    value: "Pending",
                  ),
                  const DropdownMenuItem(
                    child: Text("Completed"),
                    value: "Completed",
                  )
                ],
                onChanged: (status) {
                  setState(() {
                    _status = status.toString();
                  });
                },
              ),
              // DatetimePickerWidget(),
              Container(height: 16),
              SizedBox(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  child:
                      const Text('Save', style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    var msg = "";
                    if (taskId == "create") {
                      msg = 'created';
                      await notifier?.addTask(
                          _titleController.text,
                          _descriptionController.text,
                          formaDateTimeForWriting(selectedDateTime),
                          _status);
                    } else {
                      msg = 'updated';
                      await notifier?.updatetask(
                          _tasks[int.parse(taskId)].id,
                          _titleController.text,
                          _descriptionController.text,
                          formaDateTimeForWriting(selectedDateTime),
                          _status);
                    }

                    _showMaterialDialog(
                        "Task Create", "Task was successfully " + msg);
                  },
                ),
              )
            ],
          ),
        ));
  }

  String formatDateTime(DateTime dateTime) {
    dateTime = dateTime.toLocal();
    return DateFormat('d/MMM/y').add_jm().format(dateTime);
  }

  String formaDateTimeForWriting(DateTime dateTime) {
    return DateFormat('y-MM-ddTHH:mm').format(dateTime);
  }

  void _showMaterialDialog(String title, String content) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          );
        }).then((value) => Navigator.of(context).pop());
  }
}
