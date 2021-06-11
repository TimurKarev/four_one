import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/authication/view_models/landing_page_view_model.dart';

final securityProvider = Provider((ref) => SecurityViewModel(ref.read));

class SecurityViewModel {
  final Reader reader;

  SecurityViewModel(this.reader);

  bool get isUserCanCreateOrder => reader(landingPageProvider).roles.contains('order_create');

  bool get isUserCanEditOrder => reader(landingPageProvider).roles.contains('order_edit');

  bool isUserAllow({Set<String>? allow, Set<String>? deny}) {
    bool retValue = false;
    final roles = reader(landingPageProvider).roles;

    if (allow != null) {
      allow.forEach((element) {
        if (roles.contains(element)) {
          retValue = true;
        }
      });
    }
    if (deny != null) {
      deny.forEach((element) {
        if (roles.contains(element)) {
          retValue = false;
        }
      });
    }
    return retValue;
  }
}