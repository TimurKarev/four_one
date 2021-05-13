import 'package:flutter/material.dart';

class DatePickerForm extends StatefulWidget {
  const DatePickerForm({Key? key}) : super(key: key);

  @override
  _DatePickerFormState createState() => _DatePickerFormState();
}

class _DatePickerFormState extends State<DatePickerForm> {
  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(_formatDate(_dateTime),
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: _dateTime,
                firstDate: DateTime(2019),
                lastDate: DateTime(2022),
              ).then((value) => setState(() {
                    _dateTime = value!;
                  }));
            },
            child: Icon(Icons.date_range),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}.${dt.month}.${dt.year}';
  }
}
