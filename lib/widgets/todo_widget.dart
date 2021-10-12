import 'package:flutter/material.dart';
import 'package:flutter_todo_app/widgets/task_form.dart';
import 'package:intl/intl.dart';

class ToDoCard extends StatefulWidget {
  final String title;
  final String description;
  final DateTime duedate;
  final String status;
  final String id;
  ToDoCard({
    Key? key,
    required this.title,
    required this.description,
    required this.duedate,
    required this.status,
    required this.id,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ToDoCardState createState() =>
      // ignore: no_logic_in_create_state
      _ToDoCardState(title, description, duedate, status, id);
}

class _ToDoCardState extends State<ToDoCard> {
  final String title;
  final String description;
  final DateTime duedate;
  final String status;
  final String id;

  _ToDoCardState(
      this.title, this.description, this.duedate, this.status, this.id);

  String formatDateTime(DateTime dateTime) {
    dateTime = dateTime.toLocal();
    return DateFormat('d/MMM/y').add_jm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: ListTile(
            title: Text(title),
            subtitle: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  // ignore: prefer_const_constructors
                  TextSpan(
                      text: 'Description: ',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: description + '\n'),
                  const TextSpan(
                      text: 'Due Date: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: formatDateTime(duedate) + '\n'),
                  const TextSpan(
                      text: 'Status: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: status),
                ],
              ),
            ),
          )),
    );
  }
}
