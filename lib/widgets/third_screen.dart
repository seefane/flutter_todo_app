import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/models/edit_task.dart';
import 'package:flutter_todo_app/api/models/task_model.dart';
import 'package:flutter_todo_app/api/services.dart';
import 'package:flutter_todo_app/api/task_provider.dart';
import 'package:flutter_todo_app/widgets/del_dialog.dart';
import 'package:flutter_todo_app/widgets/task_form.dart';
import 'package:flutter_todo_app/widgets/todo_widget.dart';
import 'package:provider/provider.dart';

late Future<List<Task>> taskList;

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({Key? key}) : super(key: key);

  @override
  _CompletedTaskScreenState createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  TaskProvider? notifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final notifier = Provider.of<TaskProvider>(context);
    if (this.notifier != notifier) {
      this.notifier = notifier;
      Future.microtask(() => notifier.fetchTasks());
    }
  }

  @override
  Widget build(BuildContext context) {
    var _tasks = notifier?.gettasks;

    if (_tasks != null) {
      _tasks = getcompletedTasks(_tasks);
    }
    return _tasks == null
        ? Center(child: const CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: _pullRefresh,
            child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: ValueKey(_tasks![index].id),
                      direction: DismissDirection.startToEnd,
                      background: Container(
                          color: Colors.red,
                          padding: const EdgeInsets.only(left: 16),
                          child: const Align(
                            child: Icon(Icons.delete, color: Colors.white),
                            alignment: Alignment.centerLeft,
                          )),
                      onDismissed: (direction) {},
                      confirmDismiss: (direction) async {
                        final result = await showDialog(
                            context: context,
                            builder: (context) => const TaskDelete());

                        if (result == true) {
                          notifier?.delTask(_tasks![index].id.toString());
                          notifier?.fetchTasks();
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => TaskForm(
                                    taskId: index.toString(),
                                  )));
                        },
                        child: ToDoCard(
                            title: _tasks[index].title,
                            description: _tasks[index].description,
                            duedate: _tasks[index].due_date,
                            status: _tasks[index].status,
                            id: _tasks[index].id.toString()),
                      ));
                }),
          );
  }

  List<Task> getcompletedTasks(List<Task> tasks) {
    List<Task> completedtasks = [];
    for (var task in tasks) {
      if (task.status == "Completed") {
        completedtasks.add(task);
      }
    }
    return completedtasks;
  }

  Future<void> _pullRefresh() async {
    notifier!.fetchTasks();
  }
}
