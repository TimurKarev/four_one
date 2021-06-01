import 'package:flutter/material.dart';
import 'package:four_one/four_one/ui/create_entry_widget.dart';
import 'package:four_one/four_one/ui/data_table_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class TableScreenBig extends StatelessWidget {
  const TableScreenBig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Таблица 4.1  development'),
      ),
      body: DataTableWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.vxNav.push(Uri(path: CreateEntryWidget.path));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
