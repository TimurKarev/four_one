import 'package:freezed_annotation/freezed_annotation.dart';
part 'common_order_model.freezed.dart';

@freezed
class CommonOrderModel with _$CommonOrderModel {
  factory CommonOrderModel({
    required String client,
    required String object,
    required String orderNum,
    required String contract,
  }) = _CommonOrderModel;
}