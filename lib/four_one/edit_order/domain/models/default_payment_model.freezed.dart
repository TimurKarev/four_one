// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'default_payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DefaultPaymentModelTearOff {
  const _$DefaultPaymentModelTearOff();

  _DefaultPaymentModel call(
      {required String str,
      required String type,
      required double percentage,
      required double cash,
      required DateTime date}) {
    return _DefaultPaymentModel(
      str: str,
      type: type,
      percentage: percentage,
      cash: cash,
      date: date,
    );
  }
}

/// @nodoc
const $DefaultPaymentModel = _$DefaultPaymentModelTearOff();

/// @nodoc
mixin _$DefaultPaymentModel {
  String get str => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double get percentage => throw _privateConstructorUsedError;
  double get cash => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DefaultPaymentModelCopyWith<DefaultPaymentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DefaultPaymentModelCopyWith<$Res> {
  factory $DefaultPaymentModelCopyWith(
          DefaultPaymentModel value, $Res Function(DefaultPaymentModel) then) =
      _$DefaultPaymentModelCopyWithImpl<$Res>;
  $Res call(
      {String str, String type, double percentage, double cash, DateTime date});
}

/// @nodoc
class _$DefaultPaymentModelCopyWithImpl<$Res>
    implements $DefaultPaymentModelCopyWith<$Res> {
  _$DefaultPaymentModelCopyWithImpl(this._value, this._then);

  final DefaultPaymentModel _value;
  // ignore: unused_field
  final $Res Function(DefaultPaymentModel) _then;

  @override
  $Res call({
    Object? str = freezed,
    Object? type = freezed,
    Object? percentage = freezed,
    Object? cash = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      str: str == freezed
          ? _value.str
          : str // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      percentage: percentage == freezed
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      cash: cash == freezed
          ? _value.cash
          : cash // ignore: cast_nullable_to_non_nullable
              as double,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
abstract class _$DefaultPaymentModelCopyWith<$Res>
    implements $DefaultPaymentModelCopyWith<$Res> {
  factory _$DefaultPaymentModelCopyWith(_DefaultPaymentModel value,
          $Res Function(_DefaultPaymentModel) then) =
      __$DefaultPaymentModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String str, String type, double percentage, double cash, DateTime date});
}

/// @nodoc
class __$DefaultPaymentModelCopyWithImpl<$Res>
    extends _$DefaultPaymentModelCopyWithImpl<$Res>
    implements _$DefaultPaymentModelCopyWith<$Res> {
  __$DefaultPaymentModelCopyWithImpl(
      _DefaultPaymentModel _value, $Res Function(_DefaultPaymentModel) _then)
      : super(_value, (v) => _then(v as _DefaultPaymentModel));

  @override
  _DefaultPaymentModel get _value => super._value as _DefaultPaymentModel;

  @override
  $Res call({
    Object? str = freezed,
    Object? type = freezed,
    Object? percentage = freezed,
    Object? cash = freezed,
    Object? date = freezed,
  }) {
    return _then(_DefaultPaymentModel(
      str: str == freezed
          ? _value.str
          : str // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      percentage: percentage == freezed
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      cash: cash == freezed
          ? _value.cash
          : cash // ignore: cast_nullable_to_non_nullable
              as double,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_DefaultPaymentModel implements _DefaultPaymentModel {
  _$_DefaultPaymentModel(
      {required this.str,
      required this.type,
      required this.percentage,
      required this.cash,
      required this.date});

  @override
  final String str;
  @override
  final String type;
  @override
  final double percentage;
  @override
  final double cash;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'DefaultPaymentModel(str: $str, type: $type, percentage: $percentage, cash: $cash, date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DefaultPaymentModel &&
            (identical(other.str, str) ||
                const DeepCollectionEquality().equals(other.str, str)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.percentage, percentage) ||
                const DeepCollectionEquality()
                    .equals(other.percentage, percentage)) &&
            (identical(other.cash, cash) ||
                const DeepCollectionEquality().equals(other.cash, cash)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(str) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(percentage) ^
      const DeepCollectionEquality().hash(cash) ^
      const DeepCollectionEquality().hash(date);

  @JsonKey(ignore: true)
  @override
  _$DefaultPaymentModelCopyWith<_DefaultPaymentModel> get copyWith =>
      __$DefaultPaymentModelCopyWithImpl<_DefaultPaymentModel>(
          this, _$identity);
}

abstract class _DefaultPaymentModel implements DefaultPaymentModel {
  factory _DefaultPaymentModel(
      {required String str,
      required String type,
      required double percentage,
      required double cash,
      required DateTime date}) = _$_DefaultPaymentModel;

  @override
  String get str => throw _privateConstructorUsedError;
  @override
  String get type => throw _privateConstructorUsedError;
  @override
  double get percentage => throw _privateConstructorUsedError;
  @override
  double get cash => throw _privateConstructorUsedError;
  @override
  DateTime get date => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DefaultPaymentModelCopyWith<_DefaultPaymentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
