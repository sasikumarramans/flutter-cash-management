class LoginOtpResponse {
  String message;
  int? otpId;

  LoginOtpResponse({
    required this.message,
    this.otpId,
  });

  factory LoginOtpResponse.fromJsonList(List<dynamic> json) {
    return LoginOtpResponse.fromJson(json.first);
  }

  factory LoginOtpResponse.fromJson(Map<String, dynamic> json) =>
      LoginOtpResponse(
        message: json["message"] ?? "",
        otpId: json["otpId"] ?? -1,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "otpId": otpId,
      };
}
