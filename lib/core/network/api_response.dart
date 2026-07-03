import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/core/network/end_points.dart';
import 'package:flutter_boilerplate/core/network/paginated_data.dart';

class ApiResponse<T> {
  final int httpStatusCode;
  final int statusCode;
  final String message;
  final T? data;
  final Map<String, List<String>>? errors;
  final bool? success;
  final String? code;

  ApiResponse({
    required this.httpStatusCode,
    required this.success,
    required this.statusCode,
    required this.message,
    this.data,
    this.errors,
    this.code,
  });

  static Map<String, List<String>>? _parseErrors(Map<String, dynamic> json) {
    Map<String, List<String>>? parsedErrors;
    if (json['error'] != null && json['error'] is Map<String, dynamic>) {
      parsedErrors = (json['error'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, List<String>.from(value)),
      );
    }
    return parsedErrors;
  }

  factory ApiResponse.fromJson(
    Response<dynamic> response,
    T Function(dynamic json)? fromDataJson,
  ) {
    final httpStatusCode = response.statusCode;
    Map<String, dynamic> json = response.data;
    return ApiResponse<T>(
      httpStatusCode: httpStatusCode ?? 0,
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? "",
      code: json['code'] ?? "",
      data: fromDataJson != null ? fromDataJson(json['results']) : null,
      errors: _parseErrors(json),
    );
  }

  static ApiResponse<PaginatedData<T>> paginatedFromJson<T>(
    Response<dynamic> response,
    T Function(dynamic json) fromDataJson,
  ) {
    final httpStatusCode = response.statusCode;
    Map<String, dynamic> json = response.data;
    final List<T> items =
        (json['results'] as List<dynamic>).map((e) => fromDataJson(e)).toList();
    return ApiResponse<PaginatedData<T>>(
      httpStatusCode: httpStatusCode ?? 0,
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? "",
      code: json['code'] ?? "",
      data: PaginatedData<T>(
        items: items,
        page: json['page'] ?? 1,
        limit: json['limit'] ?? items.length,
        totalCount: json['totalCount'] ?? EndPoints.pageSize * EndPoints.maxPages,
        pageSize: json['pageSize'] ?? items.length,
      ),
      errors: _parseErrors(json),
    );
  }
}
