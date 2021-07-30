import 'package:freezed_annotation/freezed_annotation.dart';
part 'default_payment_model.freezed.dart';

@freezed
class DefaultPaymentModel with _$DefaultPaymentModel {
  factory DefaultPaymentModel({
    required String str,
    required String type,
    required double percentage,
    required double cash,
    required DateTime date,
  }) = _DefaultPaymentModel;
}