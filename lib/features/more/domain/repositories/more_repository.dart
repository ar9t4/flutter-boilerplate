import 'package:flutter_boilerplate/features/more/domain/entities/more.dart';

abstract interface class MoreRepository {
  List<More> fetchMoreItems();
}
