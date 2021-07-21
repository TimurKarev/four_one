import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:four_one/four_one/models/entry/table_model.dart';
import 'package:four_one/four_one/providers/providers.dart';

class SaveExcelDialog extends ConsumerWidget {

  SaveExcelDialog({Key? key}) : super(key: key){
    _controller.text = _fileName;
  }

  final double _contentWidth = 250;
  final double _contentHeight = 80;

  final TextEditingController _controller = TextEditingController();

  String get _fileName => 'отчет4_1';


  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return AlertDialog(
      title: Text('Сохранение отчета в excel'),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'OK');
          },
          child: const Text('OK'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
          },
          child: const Text('Cancel'),
        ),
      ],
      content:
        _getContent(watch),
    );
  }

  Widget _getContent(ScopedReader watch) {
    return watch(tableDataProvider).when(
      data: (data) {
        return _getContentWithData(data);
      },
      loading: () => CircularProgressIndicator.adaptive(),
      error: (e, _) => Text(e.toString()),
    );

  }

  Widget _getContentWithData(TableModel data) {
    return Container(
      height: _contentHeight,
      width: _contentHeight,
      child: Center(
        child: TextFormField(
          controller: _controller,
        ),
      ),
    );
  }
}
