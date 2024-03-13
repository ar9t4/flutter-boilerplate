import 'package:json_annotation/json_annotation.dart';

part 'async_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class AsyncResponse<T> {
  bool? loading;
  String? error;
  T? data;

  AsyncResponse({this.loading, this.error, this.data});

  factory AsyncResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$AsyncResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$AsyncResponseToJson(this, toJsonT);
}
