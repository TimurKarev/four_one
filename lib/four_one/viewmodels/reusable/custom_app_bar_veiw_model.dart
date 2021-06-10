import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/authication/services/firebase_auth.dart';

final customAppBarProvider = Provider((ref) => CustomAppBarViewModel(ref.read));

class CustomAppBarViewModel {
  final Reader reader;

  late final String? name;

  CustomAppBarViewModel(this.reader);
  void logout() {
    reader(authProvider).signOut();
  }
}