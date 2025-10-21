class UserDataObject {
  String userId;
  dynamic firstName;
  dynamic lastName;
  dynamic phoneNumber;
  dynamic countryCode;
  String email;
  String profileImageUrl;
  String username;
  String address;
  String companyName;

  UserDataObject({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.countryCode,
    required this.email,
    required this.profileImageUrl,
    required this.username,
    required this.companyName,
    required this.address,
  });

  factory UserDataObject.fromJson(Map<String, dynamic> json) => UserDataObject(
        userId: json["id"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        countryCode: json["countryCode"] ?? "",
        email: json["email"] ?? "",
        profileImageUrl: json["profileImageUrl"] ?? "",
        username: json["username"] ?? "",
        address: json["address"] ?? "",
        companyName: json["companyName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "countryCode": countryCode,
        "email": email,
        "companyName": companyName,
        "address": address,
      };
}
