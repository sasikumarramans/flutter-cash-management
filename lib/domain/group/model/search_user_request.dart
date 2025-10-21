class SearchUserRequest {
  final String query;

  SearchUserRequest({required this.query});

  Map<String, dynamic> toJson() => {
        "query": query,
      };
}