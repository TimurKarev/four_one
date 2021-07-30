// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'default_schedule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DefaultScheduleModelTearOff {
  const _$DefaultScheduleModelTearOff();

  _DefaultScheduleModel call(
      {required double sum, required List<DefaultPaymentModel> payments}) {
    return _DefaultScheduleModel(
      sum: sum,
      payments: payments,
    );
  }
}

/// @nodoc
const $DefaultScheduleModel = _$DefaultScheduleModelTearOff();

/// @nodoc
mixin _$DefaultScheduleModel {
  double get sum => throw _privateConstructorUsedError;
  List<DefaultPaymentModel> get payments => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DefaultScheduleModelCopyWith<DefaultScheduleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DefaultScheduleModelCopyWith<$Res> {
  factory $DefaultScheduleModelCopyWith(DefaultScheduleModel value,
          $Res Function(DefaultScheduleModel) then) =
      _$DefaultScheduleModelCopyWithImpl<$Res>;
  $Res call({double sum, List<DefaultPaymentModel> payments});
}

/// @nodoc
class _$DefaultScheduleModelCopyWithImpl<$Res>
    implements $DefaultScheduleModelCopyWith<$Res> {
  _$DefaultScheduleModelCopyWithImpl(this._value, this._then);

  final DefaultScheduleModel _value;
  // ignore: unused_field
  final $Res Function(DefaultScheduleModel) _then;

  @override
  $Res call({
    Object? sum = freezed,
    Object? payments = freezed,
  }) {
    return _then(_value.copyWith(
      sum: sum == freezed
          ? _value.sum
          : sum // ignore: cast_nullable_to_non_nullable
              as double,
      payments: payments == freezed
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<DefaultPaymentModel>,
    ));
  }
}

/// @nodoc
abstract class _$DefaultScheduleModelCopyWith<$Res>
    implements $DefaultScheduleModelCopyWith<$Res> {
  factory _$DefaultScheduleModelCopyWith(_DefaultScheduleModel value,
          $Res Function(_DefaultScheduleModel) then) =
      __$DefaultScheduleModelCopyWithImpl<$Res>;
  @override
  $Res call({double sum, List<DefaultPaymentModel> payments});
}

/// @nodoc
class __$DefaultScheduleModelCopyWithImpl<$Res>
    extends _$DefaultScheduleModelCopyWithImpl<$Res>
    implements _$DefaultScheduleModelCopyWith<$Res> {
  __$DefaultScheduleModelCopyWithImpl(
      _DefaultScheduleModel _value, $Res Function(_DefaultScheduleModel) _then)
      : super(_value, (v) => _then(v as _DefaultScheduleModel));

  @override
  _DefaultScheduleModel get _value => super._value as _DefaultScheduleModel;

  @override
  $Res call({
    Object? sum = freezed,
    Object? payments = freezed,
  }) {
    return _then(_DefaultScheduleModel(
      sum: sum == freezed
          ? _value.sum
          : sum // ignore: cast_nullable_to_non_nullable
              as double,
      payments: payments == freezed
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<DefaultPaymentModel>,
    ));
  }
}

/// @nodoc

class _$_DefaultScheduleModel implements _DefaultScheduleModel {
  _$_DefaultScheduleModel({required this.sum, required this.payments});

  @override
  final double sum;
  @override
  final List<DefaultPaymentModel> payments;

  @override
  String toString() {
    return 'DefaultScheduleModel(sum: $sum, payments: $payments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DefaultScheduleModel &&
            (identical(other.sum, sum) ||
                const DeepCollectionEquality().equals(other.sum, sum)) &&
            (identical(other.payments, payments) ||
                const DeepCollectionEquality()
                    .equals(other.payments, payments)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(sum) ^
      const DeepCollectionEquality().hash(payments);

  @JsonKey(ignore: true)
  @override
  _$DefaultScheduleModelCopyWith<_DefaultScheduleModel> get copyWith =>
      __$DefaultScheduleModelCopyWithImpl<_DefaultScheduleModel>(
          this, _$identity);
}

abstract class _DefaultScheduleModel implements DefaultScheduleModel {
  factory _DefaultScheduleModel(
      {required double sum,
      required List<DefaultPaymentModel> payments}) = _$_DefaultScheduleModel;

  @override
  double get sum => throw _privateConstructorUsedError;
  @override
  List<DefaultPaymentModel> get payments => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DefaultScheduleModelCopyWith<_DefaultScheduleModel> get copyWith =>
      throw _privateConstructorUsedError;
}
