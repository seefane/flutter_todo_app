import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

DateTime selectedDateTime = DateTime.now();

class DateTimePicker extends StatefulWidget {
  String picked_date_time;
  DateTimePicker({Key? key, required this.picked_date_time}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _DateTimePickerState createState() => _DateTimePickerState(picked_date_time);
}

class _DateTimePickerState extends State<DateTimePicker> {
  String picked_date_time;

  _DateTimePickerState(this.picked_date_time);

  late DateTime selected_date_time;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text(picked_date_time),
        onPressed: () async {
          final pickedDate = await _pickDate(context);
          if (pickedDate == null) return;
          final pickedTime = await _pickTime(context);
          if (pickedTime == null) return;
          setState(() {
            selected_date_time = DateTime(pickedDate.year, pickedDate.month,
                pickedDate.day, pickedTime.hour, pickedTime.minute);
            selectedDateTime = selected_date_time;
            picked_date_time =
                DateFormat('d/MMM/y').add_jm().format(selected_date_time);
          });
        });
  }

  Future<DateTime?> _pickDate(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));
  }

  Future<TimeOfDay?> _pickTime(BuildContext context) {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: DateTime.now().hour, minute: DateTime.now().minute));
  }
}


// late DateTime dateTime;

// String getText() {
//   if (dateTime == null) {
//     return 'Select DateTime';
//   } else {
//     return DateFormat('MM/dd/yyyy HH:mm').format(dateTime);
//   }
// }
