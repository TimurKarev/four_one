import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/authication/models/user_model.dart';
import 'package:four_one/authication/view_models/login_view_model.dart';
import 'package:four_one/four_one/ui/table_screen_big.dart';

import 'login_page.dart';

class LandingPage extends ConsumerWidget {
  LandingPage({Key? key}) : super(key: key);

  final userModelStream = StreamProvider<UserModel>((ref) => ref.watch(loginPageProvider).userModelStream());

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<UserModel> user = watch(userModelStream);
    return user.when(
      data: (data) {
        if (data.uid == null) {
          return LoginPage();
        } else {
          return TableScreenBig();
        }
      },
      loading: () {
        return CircularProgressIndicator();
      },
      error: (e, ee) {
        print(e.toString() + ee.toString());
        return Container(
          child: Text(
            e.toString() + ee.toString(),
          ),
        );
      },
    );
  }
}
