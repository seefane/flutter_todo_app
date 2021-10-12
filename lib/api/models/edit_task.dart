class TaskEdit {
  final String title;
  final String description;
  final DateTime date_created;
  final DateTime due_date;
  final String status;
  final String id;

  TaskEdit({
    required this.title,
    required this.description,
    required this.date_created,
    required this.due_date,
    required this.status,
    required this.id,
  });

  String get getstatus => status;

  factory TaskEdit.fromJson(Map<String, dynamic> map) {
    return TaskEdit(
        id: map['id'].toString(),
        title: map['title'],
        date_created: DateTime.parse(map['date_created']),
        due_date: DateTime.parse(map['due_date']),
        status: map['status'],
        description: map['description']);
  }
}
