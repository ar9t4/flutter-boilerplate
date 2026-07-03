import 'package:flutter_boilerplate/core/network/result.dart';
import 'package:flutter_boilerplate/features/users/data/models/user.dart';
import 'package:flutter_boilerplate/core/network/paginated_data.dart';

abstract interface class UsersRepository {
  Future<Result<PaginatedData<User>>> getUsers(String errorMessage, int page);
}
