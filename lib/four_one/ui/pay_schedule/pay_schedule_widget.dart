import 'package:flutter/material.dart';
import 'package:four_one/four_one/ui/pay_schedule/pay_options_dropdown.dart';

enum PayType {
  percentage,
  cash,
  all,
}

extension ParseToString on PayType {
  String forMainText() {
    switch (this) {
      case PayType.percentage:
        return '%';
      case PayType.cash:
        return 'руб.';
      case PayType.all:
        return 'Окончательный';
    }
  }
}

class PayScheduleWidget extends StatefulWidget {
  const PayScheduleWidget({Key? key}) : super(key: key);

  @override
  _PayScheduleWidgetState createState() => _PayScheduleWidgetState();
}

class _PayScheduleWidgetState extends State<PayScheduleWidget> {
  PayType _payType = PayType.percentage;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
