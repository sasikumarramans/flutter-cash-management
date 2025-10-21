class SearchEntriesRequest {
  final String query;
  final int bookId;
  final int page;
  final int size;
  final String? sortBy;
  final String? sortDir;

  SearchEntriesRequest({
    required this.query,
    required this.bookId,
    this.page = 0,
    this.size = 20,
    this.sortBy,
    this.sortDir,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'query': query,
      'bookId': bookId,
      'page': page,
      'size': size,
    };
    if (sortBy != null) map['sortBy'] = sortBy;
    if (sortDir != null) map['sortDir'] = sortDir;
    return map;
  }
}
