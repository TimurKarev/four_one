import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:four_one/four_one/models/four_one_model.dart';
import 'package:four_one/four_one/ui/data_table.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<Map<String, dynamic>> data = _loadJson(context);
    return FutureBuilder<Map<String, dynamic>>(
      future: data,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasData) {
          return DataTableWidget(
            model: FourOneModel.fromJSON(snapshot.data!),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<Map<String, dynamic>> _loadJson(BuildContext context) async {
    final String response =
        await rootBundle.loadString('assets/four_one/json/json.json');
    final data = await json.decode(response);
    return data;
  }
}
