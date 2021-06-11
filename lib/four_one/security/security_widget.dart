import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/security/security_view_model.dart';

class SecurityWidget extends StatelessWidget {
  const SecurityWidget(
      {Key? key, this.allow, this.deny, required this.child, this.errorWidget})
      : super(key: key);

  final Set<String>? allow;
  final Set<String>? deny;
  final Widget child;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    final security = context.read(securityProvider);
    if (security.isUserAllow(allow: allow, deny: deny)) {
      return child;
    }
    return errorWidget ?? Container(
      child: Center(child: Text('Не хватает прав доступа для просмотра данной страницы')),
    );
  }
}
