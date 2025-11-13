class GetActivitiesRequest {
  final String type;
  final int page;
  final int size;
  final String sortBy;
  final String sortDir;

  GetActivitiesRequest({
    this.type = 'all',
    this.page = 0,
    this.size = 20,
    this.sortBy = 'createdAt',
    this.sortDir = 'desc',
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'page': page,
        'size': size,
        'sortBy': sortBy,
        'sortDir': sortDir,
      };
}