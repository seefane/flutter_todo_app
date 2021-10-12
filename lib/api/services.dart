import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/api/models/edit_task.dart';
import 'package:flutter_todo_app/api/models/task_model.dart';
import 'package:http/http.dart' as http;

class TaskApi {
  // ignore: non_constant_identifier_names
  final String api_url = "http://10.0.2.2:8000/api";
  final String token = "6c9307fed789810676b87bef299f1620cd769564";

  Future<List<Task>> fetchtasks() async {
    final response = await http.get(
      Uri.parse(api_url + "/user-tasks/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<Task>((json) => Task.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<TaskEdit> fetchTask(String taskid) async {
    final response = await http.get(
      Uri.parse(('$api_url/task/$taskid/')),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      return TaskEdit.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Task');
    }
  }

  Future<TaskEdit> createTask(
      String title, String description, String dueDate, String status) async {
    final response = await http.post(
      Uri.parse(api_url + "/task/create/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'description': description,
        'due_date': dueDate,
        'status': status,
      }),
    );

    if (response.statusCode == 201) {
      return TaskEdit.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create Task.');
    }
  }

  Future<TaskEdit> updateTask(String taskid, String title, String description,
      String duedate, String status) async {
    final response = await http.put(
      Uri.parse(api_url + "/task/$taskid/edit/"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'description': description,
        'status': status,
        'due_date': duedate
      }),
    );

    if (response.statusCode == 200) {
      return TaskEdit.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update Task.');
    }
  }

  Future<Task> deleteTask(String id) async {
    final http.Response response = await http.delete(
      Uri.parse(api_url + '/task/$id/delete/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Token $token',
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON. After deleting,
      // you'll get an empty JSON `{}` response.
      // Don't return `null`, otherwise `snapshot.hasData`
      // will always return false on `FutureBuilder`.
      print(Task.fromJson(jsonDecode(response.body)));
      return Task.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete task.');
    }
  }
}
