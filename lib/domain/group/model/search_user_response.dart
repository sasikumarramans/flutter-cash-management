class SearchUserResponse {
  final List<SearchUserData>? data;
  final String? error;

  SearchUserResponse({
    this.data,
    this.error,
  });

  static SearchUserResponse fromJsonList(List<dynamic> jsonList) {
    return SearchUserResponse(
      data: jsonList
          .map((json) => SearchUserData.fromJson(json as Map<String, dynamic>))
          .toList(),
    );
  }
}

class SearchUserData {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String username;
  final String profileImageUrl;

  SearchUserData({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.username,
    required this.profileImageUrl,
  });

  factory SearchUserData.fromJson(Map<String, dynamic> json) {
    return SearchUserData(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      username: json['username'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'username': username,
        'profileImageUrl': profileImageUrl,
      };
}
