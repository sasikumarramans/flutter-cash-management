class GetRecentEntriesRequest {
  final String? query;
  final int page;
  final int size;

  GetRecentEntriesRequest({
    this.query,
    required this.page,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'page': page,
      'size': size,
    };
    if (query != null && query!.isNotEmpty) {
      json['query'] = query;
    }
    return json;
  }
}
