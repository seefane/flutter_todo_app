import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/models/edit_task.dart';
import 'package:flutter_todo_app/api/services.dart';
import 'package:flutter_todo_app/api/task_provider.dart';
import 'package:flutter_todo_app/widgets/first_screen.dart';
import 'package:flutter_todo_app/widgets/task_form.dart';
import 'package:flutter_todo_app/widgets/third_screen.dart';
import 'package:flutter_todo_app/widgets/todo_widget.dart';
import 'package:provider/provider.dart';

import '../api/models/task_model.dart';
import 'del_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("ToDo App"),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'All'),
                Tab(text: 'Completed'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [FirstScreen(), CompletedTaskScreen()],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const TaskForm(
                        taskId: "create",
                      )));
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ));
  }
}

class FullScreenDialog extends StatelessWidget {
  final String title;
  final String description;
  final String status;

  const FullScreenDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6200EE),
        title: const Text('Add a new task'),
      ),
      body: Column(children: <Widget>[TextFormField()]),
    );
  }
}
