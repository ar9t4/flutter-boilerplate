// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AsyncResponse<T> _$AsyncResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    AsyncResponse<T>(
      loading: json['loading'] as bool?,
      error: json['error'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$AsyncResponseToJson<T>(
  AsyncResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'loading': instance.loading,
      'error': instance.error,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
