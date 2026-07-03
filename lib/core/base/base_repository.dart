import 'package:flutter_boilerplate/core/network/api_response.dart';
import 'package:flutter_boilerplate/core/network/dio_service.dart';
import 'package:flutter_boilerplate/core/network/result.dart';

abstract class BaseRepository {
  Future<Result<T>> executeApi<T>({
    required Future<ApiResponse<T>> Function() request,
    required String errorMessage,
  }) async {
    try {
      // execute api
      final response = await request();
      final isSuccess = response.httpStatusCode == 200 ||
          response.httpStatusCode == 201 ||
          response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.success == true;
      if (isSuccess) {
        return Success(value: response.data as T);
      }
      // show error
      return Failure(error: Error(-1, errorMessage, response.code));
    } on AppNetworkException catch (e) {
      final code = e.responseData is Map<String, dynamic>
          ? e.responseData['code'] as String?
          : null;
      // show error
      return Failure(error: Error(e.statusCode, e.message, code));
    }
  }
}
