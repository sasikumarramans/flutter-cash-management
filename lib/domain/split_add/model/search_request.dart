class SearchRequest {
  final String query;
  final int friendsLimit;
  final int groupsLimit;

  SearchRequest({
    required this.query,
    this.friendsLimit = 10,
    this.groupsLimit = 10,
  });

  Map<String, dynamic> toJson() => {
        'query': query,
        'friendsLimit': friendsLimit,
        'groupsLimit': groupsLimit,
      };
}