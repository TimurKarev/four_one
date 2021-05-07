import 'package:flutter/material.dart';
import 'package:four_one/four_one/models/four_one_model.dart';
import 'package:four_one/four_one/ui/create_entry_widget.dart';
import 'package:four_one/four_one/ui/data_table.dart';
import 'package:velocity_x/velocity_x.dart';

class TableScreenBig extends StatelessWidget {
  const TableScreenBig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DataTableWidget(model: FourOneModel.empty()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.vxNav.push(Uri(path: CreateEntryWidget.path));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
