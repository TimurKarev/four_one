import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/viewmodels/entry/create_entry_viewmodel.dart';

class SaveEntryFloatingButton extends ConsumerWidget {
  SaveEntryFloatingButton({Key? key}) : super(key: key);

  final _enableProvider = Provider<bool>((ref) {
    ref.watch(createEntryProvider);
    return ref.watch(createEntryProvider.notifier).saveButtonEnabled;
  });

  @override
  FloatingActionButton build(BuildContext context, ScopedReader watch) {
    final enable = watch(_enableProvider);
    return FloatingActionButton(
      child: Icon(Icons.save),
      onPressed: enable ? () {
        context.read(createEntryProvider.notifier).saveEntry();
      } : null,
      backgroundColor: enable ? Colors.blue : Colors.grey,
    );
  }
}
