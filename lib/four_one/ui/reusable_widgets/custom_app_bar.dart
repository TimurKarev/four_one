import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/viewmodels/reusable/custom_app_bar_veiw_model.dart';

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
            context.read(customAppBarProvider).logout();
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
    print(userName);
    return Row(
      children: [
        Text('title'),
        //Expanded(child: Container()),
        Text(userName, style: TextStyle(color: Colors.white),),
      ],
    );
  }
}
