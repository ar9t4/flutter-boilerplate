import 'package:flutter_boilerplate/remote/api_response.dart';
import 'package:flutter_boilerplate/remote/dio_service.dart';
import 'package:flutter_boilerplate/remote/result.dart';

mixin ApiExecutor {
  Future<void> executeApi<T>({
    required Future<ApiResponse<T>> Function() request,
    required String errorMessage,
    required void Function(Result<T> result) onUpdateResult,
    required void Function(ApiResponse<T> response) onSuccess,
  }) async {
    try {
      // show loader
      onUpdateResult(Result<T>(loading: true));
      // execute api
      final response = await request();
      final isSuccess = response.httpStatusCode == 200 ||
          response.httpStatusCode == 201 ||
          response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.success == true;
      if (isSuccess) {
        onSuccess(response);
      } else {
        // show error
        onUpdateResult(Result<T>(error: Error(-1, errorMessage, response.code)));
      }
    } on AppNetworkException catch (e) {
      final code = (e.responseData is Map<String, dynamic>) ? e.responseData['code'] as String? : null; // show error
      onUpdateResult(Result<T>(error: Error(e.statusCode, e.message, code)));
    }
  }
}
