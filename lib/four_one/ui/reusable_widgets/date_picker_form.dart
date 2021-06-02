import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/utils/formatters.dart';

class DatePickerForm extends ConsumerWidget {
  final Provider<DateTime> provider;
  final Function(BuildContext context, DateTime newValue)? setDate;

  DatePickerForm({Key? key, required this.provider, required this.setDate})
      : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final date = watch(provider);
    return Container(
      child: Row(
        children: [
          Text(
            formatDate(date),
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
                initialDate: date,
                //TODO: create dynamic dates
                firstDate: DateTime(2019),
                lastDate: DateTime(2022),
              ).then((value) {
                if (value != null) {
                  setDate!(context, value);
                }
              });
            },
            child: Icon(Icons.date_range),
          ),
        ],
      ),
    );
  }
}
