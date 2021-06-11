import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/authication/models/user_model.dart';
import 'package:four_one/authication/services/firebase_auth.dart';
import 'package:four_one/authication/view_models/landing_page_view_model.dart';
import 'package:four_one/authication/view_models/login_view_model.dart';
import 'package:four_one/four_one/ui/table_screen_big.dart';

import 'login_page.dart';

class LandingPage extends ConsumerWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final provider = watch(landingPageProvider);

    if (provider.uid != null) {
      return TableScreenBig();
    } else if (context.read(authProvider).user?.uid != null){
      provider.updateModelFromAuthUser();
    }

    return LoginPage();
  }
}
