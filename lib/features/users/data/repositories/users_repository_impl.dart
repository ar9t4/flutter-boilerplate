import 'package:flutter_boilerplate/core/base/base_repository.dart';
import 'package:flutter_boilerplate/core/network/result.dart';
import 'package:flutter_boilerplate/features/users/data/models/user.dart';
import 'package:flutter_boilerplate/features/users/domain/repositories/users_repository.dart';
import 'package:flutter_boilerplate/core/network/api_response.dart';
import 'package:flutter_boilerplate/core/network/dio_service.dart';
import 'package:flutter_boilerplate/core/network/end_points.dart';
import 'package:flutter_boilerplate/core/network/http_method.dart';
import 'package:flutter_boilerplate/core/network/paginated_data.dart';

class UsersRepositoryImpl extends BaseRepository implements UsersRepository {
  final DioService dio;

  UsersRepositoryImpl({required this.dio});

  @override
  Future<Result<PaginatedData<User>>> getUsers(
    String errorMessage,
    int page,
  ) async {
    final response = await executeApi(
      request: () {
        return dio.request<ApiResponse<PaginatedData<User>>>(
          path: EndPoints.getUsers,
          method: HttpMethod.get,
          queryParameters: {
            'page': page,
            'results': EndPoints.pageSize,
          },
          parser: (response) => ApiResponse.paginatedFromJson(
            response,
            (data) => User.fromJson(data),
          ),
        );
      },
      errorMessage: errorMessage,
    );
    return response;
  }
}
