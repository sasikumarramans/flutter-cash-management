class GetFriendsRequest {
  final int page;
  final int size;

  GetFriendsRequest({
    this.page = 0,
    this.size = 20,
  });

  Map<String, dynamic> toJson() => {
        'page': page,
        'size': size,
      };
}