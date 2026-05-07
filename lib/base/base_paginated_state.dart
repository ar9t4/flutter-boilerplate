import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/base/base_state.dart';

abstract class BasePaginatedState<T extends StatefulWidget>
    extends BaseState<T> {
  bool _paginationLock = false;
  final ScrollController scrollController = ScrollController();

  void initPaginationController({
    required bool Function() canLoadMore,
    required VoidCallback onLoadMore,
    int triggerOffset = 200,
  }) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - triggerOffset) {
        _tryLoadMore(canLoadMore: canLoadMore, onLoadMore: onLoadMore);
      }
    });
  }

  void ensureScrollableContentFilled({
    required bool Function() canLoadMore,
    required VoidCallback onLoadMore,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!scrollController.hasClients) return;
      try {
        final position = scrollController.position;
        if (position.maxScrollExtent <= 0) {
          _tryLoadMore(canLoadMore: canLoadMore, onLoadMore: onLoadMore);
        }
      } catch (e) {
        // Scroll position not yet attached, ignore for now
      }
    });
  }

  void _tryLoadMore({
    required bool Function() canLoadMore,
    required VoidCallback onLoadMore,
  }) {
    if (_paginationLock || !canLoadMore()) return;
    _paginationLock = true;
    onLoadMore();
    Future.delayed(const Duration(milliseconds: 500), () {
      _paginationLock = false;
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
