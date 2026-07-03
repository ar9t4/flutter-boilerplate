class PaginatedData<T> {
  List<T>? items;
  int page;
  int limit;
  int totalCount;
  int pageSize;
  bool hasMore;

  PaginatedData({
    required this.items,
    required this.page,
    required this.limit,
    required this.totalCount,
    required this.pageSize,
  }) : hasMore = (items?.length ?? 0) < totalCount;

  PaginatedData<T> copyWith({
    List<T>? items,
    int? page,
    int? limit,
    int? totalCount,
    int? pageSize,
  }) {
    return PaginatedData(
      items: items ?? this.items,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      totalCount: totalCount ?? this.totalCount,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  PaginatedData<T> merge(PaginatedData<T> newPage) {
    return PaginatedData(
      items: [...?items, ...?newPage.items],
      page: newPage.page,
      limit: newPage.limit,
      totalCount: newPage.totalCount,
      pageSize: newPage.pageSize,
    );
  }
}
