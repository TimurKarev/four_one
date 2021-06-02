import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/viewmodels/entry/create_entry_viewmodel.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

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
      child: Focus(
        onFocusChange: (bool focus) {
          if (!focus) {
            _updateModel(context);
          }
        },
        child: TextFormField(
          controller: controller,
          inputFormatters: isNumeric
              ? [
                  ThousandsFormatter(allowFraction: true),
                ]
              : null,
          onEditingComplete: () => _updateModel(context),
          decoration: InputDecoration(
            labelText: labelText,
          ),
        ),
      ),
    );
  }

  void _updateModel(BuildContext context) {
    context.read(createEntryProvider.notifier).update();
  }
}
