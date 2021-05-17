import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/viewmodels/payment_edit_viewmodel.dart';

class DatePickerForm extends StatefulWidget {
  DateTime? dateTime;

  DatePickerForm({Key? key, this.dateTime}) : super(key: key) {
    if (dateTime == null) {
      dateTime = DateTime(1996);
    }
  }

  @override
  _DatePickerFormState createState() => _DatePickerFormState();
}

class _DatePickerFormState extends State<DatePickerForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            _formatDate(widget.dateTime!),
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
                initialDate: widget.dateTime!,
                firstDate: DateTime(2019),
                lastDate: DateTime(2022),
              ).then((value) => setState(() {
                    if (value != null) {
                      context.read(paymentEditProvider.notifier).date = value;
                    }
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
