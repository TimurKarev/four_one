import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/providers/providers.dart';
import 'package:four_one/four_one/viewmodels/entry/create_entry_viewmodel.dart';

final clientListProvider = Provider.autoDispose((ref) {
  return ref.watch(tableDataProvider).when(
      data: (value) {
        Set<String> retList = {};
        value.rowList.forEach((element) {
          retList.add(element.client);
        });
        return retList;
      },
      loading: () => {},
      error: (Object error, StackTrace? stackTrace) => {});
});


class ClientInputWidget extends ConsumerWidget {
  const ClientInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final v = watch(clientListProvider);
    final Set<String> clientList = v as Set<String>;
    return Container(
      child: TypeAheadFormField<String?>(
        onSuggestionSelected: (String? suggestion) {
          context
              .read(createEntryProvider.notifier)
              .clientController
              .text = suggestion!;
        },
        itemBuilder: (context, String? suggestion) {
          return ListTile(
            title: Text(suggestion!),
          );
        },
        suggestionsCallback: (String pattern) {
          return clientList.where((element) {
            return element.contains(pattern);
          });
        },
        noItemsFoundBuilder: (context) => Container(
          height: 30.0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('  новый заказчик'),
          ),
        ),
        textFieldConfiguration: TextFieldConfiguration(
          controller: context
              .read(createEntryProvider.notifier)
              .clientController,
          decoration: InputDecoration(
            labelText: 'Заказчик',
          ),
        ),
      ),
    );
  }
}
