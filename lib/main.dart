import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/services.dart';
import 'package:flutter_todo_app/widgets/homepage.dart';
import 'package:provider/provider.dart';

import 'api/task_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'ToDoApp',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage()),
    );
  }
}
