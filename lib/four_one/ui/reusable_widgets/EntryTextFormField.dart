import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EntryTextFormField extends StatelessWidget {
  const EntryTextFormField(
      {Key? key,
      required this.controller,
      this.isNumeric = false,
      this.labelText = ''})
      : super(key: key);

  final TextEditingController controller;
  final bool isNumeric;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        inputFormatters: isNumeric ? [
          FilteringTextInputFormatter.allow(
              RegExp(r'(^\d*\.?\d*)')),
        ] : null,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}
