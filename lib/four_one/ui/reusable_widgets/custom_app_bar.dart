import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/authication/view_models/landing_page_view_model.dart';
import 'package:four_one/four_one/ui/reusable_widgets/save_excel_dialog.dart';
import 'package:four_one/four_one/utils/exel_helper.dart';



class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom({Key? key, required this.title, required this.userName}) : super(key: key);

  final String title;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _getTitle(),
      actions: [
        TextButton(
          onPressed: () async {
            //Uint8List bytes = await ExelHelper.generateExcel();
            //Save and launch the file.
            // await

            await showDialog(
                context: context,
                builder: (_) {
                  return SaveExcelDialog();
                });
          },
          child: Icon(
            Icons.download,
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () async {
            context.read(landingPageProvider).logout();
          },
          child: Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);

  Widget _getTitle() {
    return Row(
      children: [
        Text(title),
        Expanded(child: Container()),
        Text(userName, style: TextStyle(color: Colors.white),),
      ],
    );
  }
}
