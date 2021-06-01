import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/models/big_table_model.dart';
import 'package:four_one/four_one/utils/date_formatter.dart';
import 'package:four_one/four_one/viewmodels/edit/ready_date_edit_viewmodel.dart';

class ReadyDateEditDialog extends ConsumerWidget {
  final BigTableModel model;

  ReadyDateEditDialog({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final provider = watch(readyDateEditProvider(model.finishDate));
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () async {
            await provider.updateDatabase(model.id);
            Navigator.pop(context, 'OK');
          },
          child: const Text('OK'),
        ),
      ],
      title: Text('Готовность объекта - ${model.object}'),
      content: Container(
        child: TextButton(
          child: Text(formatDate(provider.date)),
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: provider.date,
              //TODO: create dynamic dates
              firstDate: provider.date.subtract(Duration(days: 500)),
              lastDate: DateTime.now().add(Duration(days: 500)),
            ).then((value) {
              if (value != null) {
                provider.date = value;
              }
            });
          },
        ),
      ),
    );
  }
}
