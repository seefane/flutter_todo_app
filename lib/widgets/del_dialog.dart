import 'package:flutter/material.dart';

class TaskDelete extends StatelessWidget {
  const TaskDelete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(children: const <Widget>[
        Icon(Icons.warning),
        Text("Warning \u{2757}")
      ]),
      content: const Text('Are you sure you want to delete this task?'),
      actions: <Widget>[
        TextButton(
          child: const Text('Yes'),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        TextButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
      ],
    );
  }
}
