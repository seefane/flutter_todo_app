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

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  TaskProvider? notifier;

  @override
  void didChangeDependencies() {
    final notifier = Provider.of<TaskProvider>(context, listen: false);
    if (this.notifier != notifier) {
      this.notifier = notifier;
      notifier.fetchTasks();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _tasks = Provider.of<TaskProvider>(context);
    return _tasks == null
        ? const Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            onRefresh: _pullRefresh,
            child: ListView.builder(
                itemCount: _tasks.gettasks.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: ValueKey(_tasks.gettasks[index].id),
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
                          _tasks.delTask(_tasks.gettasks[index].id.toString());
                          _tasks.fetchTasks();
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push<void>(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TaskForm(
                                        taskId: index.toString(),
                                      ))).then((value) async {
                            await _tasks.fetchTasks();
                          });
                        },
                        child: ToDoCard(
                            title: _tasks.gettasks[index].title,
                            description: _tasks.gettasks[index].description,
                            duedate: _tasks.gettasks[index].due_date,
                            status: _tasks.gettasks[index].status,
                            id: _tasks.gettasks[index].id.toString()),
                      ));
                }),
          );
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }
}

// class FirstScreen extends StatelessWidget {
//   const FirstScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var _tasks = context.watch<TaskProvider>();
//     return _tasks == null
//         ? const Center(child: CircularProgressIndicator())
//         : RefreshIndicator(
//             onRefresh: _pullRefresh,
//             child: ListView.builder(
//                 itemCount: _tasks.gettasks.length,
//                 itemBuilder: (context, index) {
//                   return Dismissible(
//                       key: ValueKey(_tasks.gettasks[index].id),
//                       direction: DismissDirection.startToEnd,
//                       background: Container(
//                           color: Colors.red,
//                           padding: const EdgeInsets.only(left: 16),
//                           child: const Align(
//                             child: Icon(Icons.delete, color: Colors.white),
//                             alignment: Alignment.centerLeft,
//                           )),
//                       onDismissed: (direction) {},
//                       confirmDismiss: (direction) async {
//                         final result = await showDialog(
//                             context: context,
//                             builder: (context) => const TaskDelete());

//                         if (result == true) {
//                           _tasks.delTask(_tasks.gettasks[index].id.toString());
//                           _tasks.fetchTasks();
//                         }
//                       },
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (_) => TaskForm(
//                                     taskId: index.toString(),
//                                   )));
//                         },
//                         child: ToDoCard(
//                             title: _tasks.gettasks[index].title,
//                             description: _tasks.gettasks[index].description,
//                             duedate: _tasks.gettasks[index].due_date,
//                             status: _tasks.gettasks[index].status,
//                             id: _tasks.gettasks[index].id.toString()),
//                       ));
//                 }),
//           );
//   }

//   Future<void> _pullRefresh() async {}
// }
