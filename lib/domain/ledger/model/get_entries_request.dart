class GetEntriesRequest {
  final int bookId;
  final int page;
  final int size;
  final String? sortBy;
  final String? sortDir;

  GetEntriesRequest({
    required this.bookId,
    this.page = 0,
    this.size = 20,
    this.sortBy,
    this.sortDir,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'bookId': bookId,
      'page': page,
      'size': size,
    };
    if (sortBy != null) map['sortBy'] = sortBy;
    if (sortDir != null) map['sortDir'] = sortDir;
    return map;
  }
}
