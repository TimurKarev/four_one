import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:four_one/four_one/models/entry/table_model.dart';
import 'package:four_one/four_one/providers/providers.dart';

class SaveExcelDialog extends StatelessWidget {

  SaveExcelDialog({Key? key}) : super(key: key);

  TableModel? tableModel;
  void setModel(TableModel model) => tableModel = model;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: 'отчет4_1');

    return AlertDialog(
      title: Text('Сохранение отчета в excel'),
      actions: [
        TextButton(
          onPressed: () async {
            if (tableModel != null && controller.text.isNotEmpty) {
              print('${tableModel!.rowList.length}');
              print('${controller.text}');
              try {
                final Uint8List bytes = await tableModel!.toExcel();
                FileSaver.instance.saveFile(
                    controller.text, bytes,
                    'xlsx', mimeType: MimeType.MICROSOFTEXCEL
                );
              } catch (e) {
                print('${e.toString()}');
              }
            }
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
      content: SaveExcelDialogContent(controller: controller, setModel: setModel),
    );
  }
}

class SaveExcelDialogContent extends ConsumerWidget {
  SaveExcelDialogContent({required this.setModel, required this.controller, Key? key}) : super(key: key);

  final double _contentWidth = 250;
  final double _contentHeight = 80;

  final TextEditingController controller;
  final Function setModel;
  //TableModel? model;

  String get _fileName => 'отчет4_1';

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return watch(tableDataProvider).when(
      data: (data) {
        setModel(data);
        return _getContentWithData();
      },
      loading: () => CircularProgressIndicator.adaptive(),
      error: (e, _) => Text(e.toString()),
    );
  }

  Widget _getContentWithData() {
    return Container(
      height: _contentHeight,
      width: _contentWidth,
      child: Center(
        child: TextFormField(
          controller: controller,
        ),
      ),
    );
  }
}