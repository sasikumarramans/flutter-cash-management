class UniqueUserNameRequest {
  final String userName;

  UniqueUserNameRequest({
    required this.userName,
  });

  factory UniqueUserNameRequest.fromJson(Map<String, dynamic> json) {
    return UniqueUserNameRequest(
      userName: json['userName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': userName,
    };
  }
}
