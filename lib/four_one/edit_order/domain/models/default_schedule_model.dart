import 'package:freezed_annotation/freezed_annotation.dart';
import 'default_payment_model.dart';
part 'default_schedule_model.freezed.dart';

@freezed
class DefaultScheduleModel with _$DefaultScheduleModel {
  factory DefaultScheduleModel({
    required double sum,
    required List<DefaultPaymentModel> payments,
  }) = _DefaultScheduleModel;
}