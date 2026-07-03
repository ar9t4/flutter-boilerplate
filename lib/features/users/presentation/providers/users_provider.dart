import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/features/users/domain/repositories/users_repository.dart';
import 'package:flutter_boilerplate/core/network/paginated_data.dart';
import 'package:flutter_boilerplate/core/network/result.dart';
import '../../data/models/user.dart';

class UsersProvider extends ChangeNotifier {
  final UsersRepository repository;
  Result<PaginatedData<User>>? usersResult;

  int _currentPage = 1;
  bool _isLoadingMore = false;

  UsersProvider({required this.repository});

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
      usersResult = Loading(loading: showLoader);
      notifyListeners();
    }
    // execute api
    final result = await repository.getUsers(errorMessage, _currentPage);
    switch (result) {
      case Failure():
        // error: only set error for first load, not pagination
        if (!loadMore) {
          usersResult = result;
        }
        break;
      case Success():
        // success
        final pageData = result.data!;
        final currentData = usersResult?.data;
        // merge new items into existing
        if (loadMore && currentData != null) {
          usersResult = Success(value: currentData.merge(pageData));
        } else {
          // first page | refreshed
          usersResult = result;
        }
        // update pagination state
        if (pageData.hasMore) {
          _currentPage++;
        }
        break;
      // handles Initial and Loading states
      case _:
        break;
    }
    _isLoadingMore = false;
    notifyListeners();
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
