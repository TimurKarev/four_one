import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/authication/services/firebase_auth.dart';
import 'package:four_one/four_one/ui/table_screen_big.dart';

import 'login_page.dart';

class LandingPage extends ConsumerWidget {
  LandingPage({Key? key}) : super(key: key);

  final userStreamProvider = StreamProvider<User?>((ref) {
    return ref.watch(authProvider).authStateChanges();
  });

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<User?> user = watch(userStreamProvider);
    return user.when(
      data: (data) {
        if (data?.uid == null) {
          return LoginPage();
        } else {
          return TableScreenBig();
        }
      },
      loading: () => CircularProgressIndicator(),
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
