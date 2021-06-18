import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/providers/providers.dart';
import 'package:four_one/four_one/ui/main_table/main_table_widget.dart';
import 'package:four_one/four_one/ui/main_table/smallest_table_widget.dart';


class MainTablelayout extends ConsumerWidget {
  const MainTablelayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return watch(tableDataProvider).when(
      data: (data) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth >= 1300.0) {
              return MainTableWidget(data: data);
            }
            if (constraints.maxWidth < 1300.0 && constraints.maxWidth >= 1150){
              return MainTableWidget(data: data, colWidth: 250.0);
            }
            return SmallestTableWidget(model: data);
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator.adaptive()),
      error: (e, __) {
        return Container(
          child: Text('Error $e'),
        );
      },
    );
  }
}
