import 'package:flutter/material.dart';

class DataTableTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  const DataTableTooltip({Key? key, required this.child, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (message.length <= 0) {
      return Container(
        child: child,
      );
    }
    return Tooltip(
      message: message,
      child: child,
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 5.0,
      ),
      textStyle: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
      ),
    );
  }
}