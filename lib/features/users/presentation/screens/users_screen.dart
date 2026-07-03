import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/base/base_paginated_state.dart';
import 'package:flutter_boilerplate/core/constants/app_dimensions.dart';
import 'package:flutter_boilerplate/core/network/paginated_data.dart';
import 'package:flutter_boilerplate/core/network/result.dart';
import 'package:flutter_boilerplate/features/users/presentation/providers/users_provider.dart';
import 'package:flutter_boilerplate/features/users/presentation/widgets/user_item.dart';
import 'package:flutter_boilerplate/features/users/presentation/widgets/user_item_shimmer.dart';
import 'package:flutter_boilerplate/core/widgets/custom_refresh_indicator.dart';
import 'package:flutter_boilerplate/core/widgets/error_layout.dart';
import 'package:flutter_boilerplate/core/widgets/load_more_progress.dart';
import 'package:flutter_boilerplate/core/widgets/no_data_layout.dart';
import 'package:flutter_boilerplate/core/widgets/shimmer_list_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../data/models/user.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends BasePaginatedState<UsersScreen> {
  late UsersProvider provider;

  @override
  void initState() {
    super.initState();
    provider = context.read<UsersProvider>();
    // fetch data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUsers();
      // listen for scroll end position for pagination
      initPaginationController(
        canLoadMore: () =>
            provider.usersResult?.data?.hasMore == true &&
            !provider.isLoadingMore,
        onLoadMore: () => _getUsers(loadMore: true),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(child: _build()),
    );
  }

  Widget _build() {
    final result = context.watch<UsersProvider>().usersResult;
    switch (result) {
      case Loading():
        // handle loading state
        return _buildLoading();
      case Failure():
        // handle error state
        return _buildError(result.error);
      case Success():
        // handle no data and data states
        return _buildData(result.data);
      case _:
        // ignore Initial state
        return SizedBox.shrink();
    }
  }

  Widget _buildLoading() {
    return ShimmerListView(
      margin: AppDimensions.defaultContentPadding,
      padding: AppDimensions.verticalListItemMargin,
      item: UserItemShimmer(),
      itemCount: 10,
    );
  }

  Widget _buildError(Error error) {
    return ErrorLayout(
      error: error,
      parentHasAppBar: true,
      onPressed: () => _getUsers(),
    );
  }

  Widget _buildData(PaginatedData<User>? data) {
    if (data?.items?.isEmpty == true) {
      // handle no data
      return NoDataLayout(
        message: l10n.no_users_found,
        parentHasAppBar: true,
      );
    } else {
      final users = data?.items ?? [];
      // check if list is too short to scroll then load more data
      ensureScrollableContentFilled(
        canLoadMore: () => data?.hasMore == true && !provider.isLoadingMore,
        onLoadMore: () => _getUsers(loadMore: true),
      );
      return CustomRefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          _getUsers(onRefresh: true);
        },
        child: Column(
          children: [
            Padding(
              padding: AppDimensions.defaultContentPadding,
              child: Row(
                children: [
                  Icon(Icons.group, size: 32, color: colorScheme.onSurface),
                  const SizedBox(width: 16),
                  Text(
                    l10n.users,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: AppDimensions.defaultContentPadding,
                itemCount: users.length + (data?.hasMore == true ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == users.length) {
                    return const LoadMoreProgress();
                  }
                  final user = users[index];
                  return UserItem(
                    user: user,
                    onPressed: () => _openUserDetails(user),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  void _getUsers({bool onRefresh = false, bool loadMore = false}) {
    provider.getUsers(
      l10n.error_get_users,
      onRefresh: onRefresh,
      loadMore: loadMore,
    );
  }

  void _openUserDetails(User user) {
    final email = Uri.encodeComponent(user.email ?? '');
    context.push('/users/detail/$email');
  }
}
