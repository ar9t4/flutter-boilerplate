import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/remote/api_executor.dart';
import 'package:flutter_boilerplate/remote/api_response.dart';
import 'package:flutter_boilerplate/remote/dio_service.dart';
import 'package:flutter_boilerplate/remote/end_points.dart';
import 'package:flutter_boilerplate/remote/http_method.dart';
import 'package:flutter_boilerplate/remote/paginated_data.dart';
import 'package:flutter_boilerplate/remote/result.dart';
import '../models/user.dart';

class UsersProvider extends ChangeNotifier with ApiExecutor {
  late DioService dio;
  Result<PaginatedData<User>>? usersResult;

  int _currentPage = 1;
  bool _isLoadingMore = false;

  UsersProvider() {
    dio = DioService();
  }

  bool get isLoadingMore => _isLoadingMore;

  Future<void> getUsers(
    String errorMessage, {
    bool onRefresh = false,
    bool loadMore = false,
    bool showLoader = true,
  }) async {
    // use cache
    if (!loadMore && !onRefresh && usersResult?.data != null) {
      return;
    }
    // prevent duplicate pagination calls
    if (loadMore && _isLoadingMore) return;
    // set flag for next page call
    if (loadMore) {
      _isLoadingMore = true;
      notifyListeners();
    } else {
      // reset for first page | refresh
      _currentPage = 1;
      usersResult = Result(loading: showLoader);
      notifyListeners();
    }
    final queryParameters = {
      'page': _currentPage,
      'results': EndPoints.pageSize,
    };
    await executeApi(
      request: () => dio.request<ApiResponse<PaginatedData<User>>>(
        path: EndPoints.getUsers,
        method: HttpMethod.get,
        queryParameters: queryParameters,
        parser: (response) => ApiResponse.paginatedFromJson(
          response,
          (data) => User.fromJson(data),
        ),
      ),
      errorMessage: errorMessage,
      onUpdateResult: (result) {
        // only set loading | error for first load, not pagination
        if (!loadMore) {
          usersResult = Result(
            loading: result.loading,
            error: result.error,
          );
          notifyListeners();
        }
      },
      onSuccess: (response) {
        final pageData = response.data;
        final currentData = usersResult?.data;
        // merge new items into existing
        if (loadMore && currentData != null) {
          usersResult = Result(data: currentData.merge(pageData!));
        } else {
          // first page | refreshed
          usersResult = Result(data: pageData);
        }
        // update pagination state
        if (pageData?.hasMore == true) {
          _currentPage++;
        }
        _isLoadingMore = false;
        notifyListeners();
      },
    );
  }

  User? getUserByEmail(String email) {
    final users = usersResult?.data?.items ?? [];
    final searchEmail = email.trim().toLowerCase();
    try {
      return users.firstWhere(
        (user) => user.email?.trim().toLowerCase() == searchEmail,
      );
    } catch (_) {
      return null;
    }
  }
}
