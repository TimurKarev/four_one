// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'common_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CommonOrderModelTearOff {
  const _$CommonOrderModelTearOff();

  _CommonOrderModel call(
      {required String client,
      required String object,
      required String orderNum,
      required String contract}) {
    return _CommonOrderModel(
      client: client,
      object: object,
      orderNum: orderNum,
      contract: contract,
    );
  }
}

/// @nodoc
const $CommonOrderModel = _$CommonOrderModelTearOff();

/// @nodoc
mixin _$CommonOrderModel {
  String get client => throw _privateConstructorUsedError;
  String get object => throw _privateConstructorUsedError;
  String get orderNum => throw _privateConstructorUsedError;
  String get contract => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CommonOrderModelCopyWith<CommonOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommonOrderModelCopyWith<$Res> {
  factory $CommonOrderModelCopyWith(
          CommonOrderModel value, $Res Function(CommonOrderModel) then) =
      _$CommonOrderModelCopyWithImpl<$Res>;
  $Res call({String client, String object, String orderNum, String contract});
}

/// @nodoc
class _$CommonOrderModelCopyWithImpl<$Res>
    implements $CommonOrderModelCopyWith<$Res> {
  _$CommonOrderModelCopyWithImpl(this._value, this._then);

  final CommonOrderModel _value;
  // ignore: unused_field
  final $Res Function(CommonOrderModel) _then;

  @override
  $Res call({
    Object? client = freezed,
    Object? object = freezed,
    Object? orderNum = freezed,
    Object? contract = freezed,
  }) {
    return _then(_value.copyWith(
      client: client == freezed
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as String,
      object: object == freezed
          ? _value.object
          : object // ignore: cast_nullable_to_non_nullable
              as String,
      orderNum: orderNum == freezed
          ? _value.orderNum
          : orderNum // ignore: cast_nullable_to_non_nullable
              as String,
      contract: contract == freezed
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$CommonOrderModelCopyWith<$Res>
    implements $CommonOrderModelCopyWith<$Res> {
  factory _$CommonOrderModelCopyWith(
          _CommonOrderModel value, $Res Function(_CommonOrderModel) then) =
      __$CommonOrderModelCopyWithImpl<$Res>;
  @override
  $Res call({String client, String object, String orderNum, String contract});
}

/// @nodoc
class __$CommonOrderModelCopyWithImpl<$Res>
    extends _$CommonOrderModelCopyWithImpl<$Res>
    implements _$CommonOrderModelCopyWith<$Res> {
  __$CommonOrderModelCopyWithImpl(
      _CommonOrderModel _value, $Res Function(_CommonOrderModel) _then)
      : super(_value, (v) => _then(v as _CommonOrderModel));

  @override
  _CommonOrderModel get _value => super._value as _CommonOrderModel;

  @override
  $Res call({
    Object? client = freezed,
    Object? object = freezed,
    Object? orderNum = freezed,
    Object? contract = freezed,
  }) {
    return _then(_CommonOrderModel(
      client: client == freezed
          ? _value.client
          : client // ignore: cast_nullable_to_non_nullable
              as String,
      object: object == freezed
          ? _value.object
          : object // ignore: cast_nullable_to_non_nullable
              as String,
      orderNum: orderNum == freezed
          ? _value.orderNum
          : orderNum // ignore: cast_nullable_to_non_nullable
              as String,
      contract: contract == freezed
          ? _value.contract
          : contract // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_CommonOrderModel implements _CommonOrderModel {
  _$_CommonOrderModel(
      {required this.client,
      required this.object,
      required this.orderNum,
      required this.contract});

  @override
  final String client;
  @override
  final String object;
  @override
  final String orderNum;
  @override
  final String contract;

  @override
  String toString() {
    return 'CommonOrderModel(client: $client, object: $object, orderNum: $orderNum, contract: $contract)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CommonOrderModel &&
            (identical(other.client, client) ||
                const DeepCollectionEquality().equals(other.client, client)) &&
            (identical(other.object, object) ||
                const DeepCollectionEquality().equals(other.object, object)) &&
            (identical(other.orderNum, orderNum) ||
                const DeepCollectionEquality()
                    .equals(other.orderNum, orderNum)) &&
            (identical(other.contract, contract) ||
                const DeepCollectionEquality()
                    .equals(other.contract, contract)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(client) ^
      const DeepCollectionEquality().hash(object) ^
      const DeepCollectionEquality().hash(orderNum) ^
      const DeepCollectionEquality().hash(contract);

  @JsonKey(ignore: true)
  @override
  _$CommonOrderModelCopyWith<_CommonOrderModel> get copyWith =>
      __$CommonOrderModelCopyWithImpl<_CommonOrderModel>(this, _$identity);
}

abstract class _CommonOrderModel implements CommonOrderModel {
  factory _CommonOrderModel(
      {required String client,
      required String object,
      required String orderNum,
      required String contract}) = _$_CommonOrderModel;

  @override
  String get client => throw _privateConstructorUsedError;
  @override
  String get object => throw _privateConstructorUsedError;
  @override
  String get orderNum => throw _privateConstructorUsedError;
  @override
  String get contract => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CommonOrderModelCopyWith<_CommonOrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}
