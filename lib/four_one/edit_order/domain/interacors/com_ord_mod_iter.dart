import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:four_one/four_one/edit_order/domain/models/common_order_model.dart';

final providerComOrdModIter =
    StateNotifierProvider<ComOrdModIter, CommonOrderModel>(
        (ref) => ComOrdModIter());

class ComOrdModIter extends StateNotifier<CommonOrderModel> {
  ComOrdModIter()
      : super(
          CommonOrderModel(
            client: '',
            object: '',
            orderNum: '',
            contract: '',
          ),
        );

  void init(CommonOrderModel model) => state = model;
}
