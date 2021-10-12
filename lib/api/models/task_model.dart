// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class Task {
  final String title;
  final String description;
  final DateTime date_created;
  final DateTime due_date;
  final String status;
  final String id;

  Task({
    required this.title,
    required this.description,
    required this.date_created,
    required this.due_date,
    required this.status,
    required this.id,
  });

  String get getstatus => status;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date_created': date_created,
      'due_date': due_date,
      'status': status,
      'id': id,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
      date_created: DateTime.parse(map['date_created']),
      due_date: DateTime.parse(map['due_date']),
      status: map['status'],
      id: map['id'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
