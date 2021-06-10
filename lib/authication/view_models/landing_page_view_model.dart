import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/authication/models/user_model.dart';
import 'package:four_one/authication/services/firebase_auth.dart';
import 'package:four_one/four_one/services/firebase/firebae_service.dart';
import 'package:four_one/four_one/services/firebase/paths.dart';

final landingPageProvider = ChangeNotifierProvider<LandingPageViewModel>(
    (ref) => LandingPageViewModel(ref.read));

class LandingPageViewModel extends ChangeNotifier {
  final Reader reader;
  UserModel _userModel = UserModel();

  LandingPageViewModel(this.reader);

  String? get uid => _userModel.uid;

  void logout() async {
    await reader(authProvider).signOut();
    await updateModelFromAuthUser();
  }

  Future<void> updateModelFromAuthUser([Map<String, dynamic>? data]) async {
    final auth = reader(authProvider);
    if (auth.user?.uid == null) {
      _userModel = UserModel();
      notifyListeners();
      return;
    }

    if (data == null) {
      data = {
        'name': auth.user?.email ?? '',
        'email': auth.user?.email ?? '',
        'uid': auth.user?.uid,
        'roles': {'not_assigned'},
      };
    }

    final document = await reader(firebaseServiceProvider)
        .getOrCreateDocument(FirebasePath.user(auth.user!.uid), data);
    _userModel.update(document);
    notifyListeners();
  }
}
