import 'package:flutter/material.dart';
import 'package:four_one/four_one/utils/formatters.dart';

class BigNumberTextWidget extends StatelessWidget {
  const BigNumberTextWidget({Key? key, required this.number}) : super(key: key);
  final String number;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Text(getFormatNum(number)),
    );
  }
}
