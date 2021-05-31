import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/utils/date_formatter.dart';

class ReadyDateEditDialog extends ConsumerWidget {
  final BigTableModel model;

  ReadyDateEditDialog({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'OK');
          },
          child: const Text('OK'),
        ),
      ],
      title: Text('Готовность объекта - ${model.object}'),
      content: Container(
        child: TextButton(
          child: Text(formatDate(model.finishDate)),
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: model.finishDate,
              //TODO: create dynamic dates
              firstDate: model.finishDate.subtract(Duration(days: 500)),
              lastDate: DateTime.now().add(Duration(days: 500)),
            ).then((value) {
              if (value != null) {
                //provider.dateFieldChanged(value, payment);
              }
            });
          },
        ),
      ),
    );
  }
}
