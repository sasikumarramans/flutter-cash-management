class BaseResponse<Q> {
  final bool isSuccessful;
  final int? errorCode;
  final String? message;
  final String? errorMsg;
  final Q? data;

  BaseResponse({
    required this.isSuccessful,
    this.errorCode = 0,
    this.message,
    this.errorMsg,
    this.data,
  });

  factory BaseResponse.fromJson(
    dynamic json, {
    Q Function(Map<String, dynamic>)? parseDataJson,
    Q Function(List<dynamic>)? parseDataJsonList,
    bool? sendCompleteResponse,
  }) {
    print("object12345");
    if (json is Map) {
      bool sendCompleteData = sendCompleteResponse ?? false;
      bool isSuccessful = json['success'] ?? true;

      final parsedData = sendCompleteData
          ? parseDataJson?.call(json as Map<String, dynamic>)
          : (json['data'] is Map<String, dynamic>)
              ? parseDataJson?.call(json['data'])
              : (json['data'] is List)
                  ? parseDataJsonList?.call(json['data'])
                  : parseDataJson?.call(json as Map<String, dynamic>);

      return BaseResponse(
        isSuccessful: isSuccessful,
        errorCode: json['errorCode'],
        message: json['message'],
        errorMsg: isSuccessful
            ? json['errorMsg']
            : (json['error'] ?? json['errorMsg']),
        data: parsedData,
      );
    } else {
      return BaseResponse(
        isSuccessful: true,
        errorCode: 1,
        message: "",
        errorMsg: "",
        data: parseDataJsonList?.call(json),
      );
    }
  }
}
