class UserResponseObject {
  String sessionToken;
  String userId;
  dynamic firstName;
  dynamic lastName;
  dynamic phoneNumber;
  dynamic countryCode;
  String email;
  String profileImageUrl;
  String username;

  UserResponseObject({
    required this.sessionToken,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.countryCode,
    required this.email,
    required this.profileImageUrl,
    required this.username,
  });

  factory UserResponseObject.fromJson(Map<String, dynamic> json) =>
      UserResponseObject(
        sessionToken: json["accessToken"] ?? "",
        userId: json["userId"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        countryCode: json["countryCode"] ?? "",
        email: json["email"] ?? "",
        profileImageUrl: json["profileImageUrl"] ?? "",
        username: json["username"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "sessionToken": sessionToken,
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "countryCode": countryCode,
        "email": email,
      };
}
