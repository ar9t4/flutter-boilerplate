import 'package:flutter_boilerplate/core/base/base_provider.dart';
import 'package:flutter_boilerplate/features/more/domain/repositories/more_repository.dart';
import '../../domain/entities/more.dart';

class MoreProvider extends BaseProvider {
  final MoreRepository repository;
  var moreItems = <More>[];

  MoreProvider({required this.repository});

  void fetchMoreItems() {
    // clear previous items
    moreItems.clear();
    moreItems.addAll(repository.fetchMoreItems());
    notifyListeners();
  }
}
