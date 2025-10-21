class UniqueUserNameResponse {
  final bool success;
  final String message;
  final String error;

  UniqueUserNameResponse(
      {required this.success, required this.message, required this.error});

  factory UniqueUserNameResponse.fromJson(Map<String, dynamic> json) {
    return UniqueUserNameResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? "",
      error: json['error'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'error': error,
    };
  }
}
