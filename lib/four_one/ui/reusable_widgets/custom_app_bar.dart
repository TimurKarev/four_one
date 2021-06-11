import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/authication/view_models/landing_page_view_model.dart';


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