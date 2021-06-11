import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/authication/models/user_model.dart';
import 'package:four_one/four_one/ui/create_entry_widget.dart';
import 'package:four_one/four_one/ui/reusable_widgets/custom_app_bar.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:four_one/authication/view_models/landing_page_view_model.dart';

import 'main_table/main_table_widget.dart';

class TableScreenBig extends StatelessWidget {
  const TableScreenBig({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Отчет 4_1 auth',
        userName: context.read(landingPageProvider).name,
      ),
      body: MainTableWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.vxNav.push(Uri(path: CreateEntryWidget.path));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
