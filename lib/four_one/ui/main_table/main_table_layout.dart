import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/ui/main_table/main_table_widget.dart';
import 'package:four_one/four_one/viewmodels/tables/big_table_view_model.dart';

class MainTablelayout extends StatelessWidget {
  const MainTablelayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth >= 1300.0) {
          return MainTableWidget();
        }
        return SmallestTableWidget();
      },
    );
  }
}

class SmallestTableWidget extends ConsumerWidget {
  const SmallestTableWidget({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    print('build');
    final provider = watch(bigTableProvider);
      return Container(
        child:
            Text('${provider.state.state}'),
      );
  }
}
