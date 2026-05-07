import 'package:flutter_boilerplate/remote/paginated_data.dart';

class ApiResponse<T> {
  final int statusCode;
  final String message;
  final T? data;
  final Map<String, List<String>>? errors;
  final bool? success;
  final String? code;

  ApiResponse({
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
    Map<String, dynamic> json,
    T Function(dynamic json)? fromDataJson,
  ) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? "",
      code: json['code'] ?? "",
      data: fromDataJson != null ? fromDataJson(json['data']) : null,
      errors: _parseErrors(json),
    );
  }

  static ApiResponse<PaginatedData<T>> paginatedFromJson<T>(
    Map<String, dynamic> json,
    T Function(dynamic json) fromDataJson,
  ) {
    final List<T> items =
        (json['data'] as List<dynamic>).map((e) => fromDataJson(e)).toList();
    return ApiResponse<PaginatedData<T>>(
      success: json['success'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? "",
      code: json['code'] ?? "",
      data: PaginatedData<T>(
        items: items,
        page: json['page'] ?? 1,
        limit: json['limit'] ?? items.length,
        totalCount: json['totalCount'] ?? items.length,
        pageSize: json['pageSize'] ?? items.length,
      ),
      errors: _parseErrors(json),
    );
  }
}
