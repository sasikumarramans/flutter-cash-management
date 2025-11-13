class GetGroupsRequest {
  final int page;
  final int size;
  final String sortBy;
  final String sortDir;

  GetGroupsRequest({
    this.page = 0,
    this.size = 20,
    this.sortBy = 'createdAt',
    this.sortDir = 'desc',
  });

  Map<String, dynamic> toJson() => {
        'page': page,
        'size': size,
        'sortBy': sortBy,
        'sortDir': sortDir,
      };
}