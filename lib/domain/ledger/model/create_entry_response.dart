import 'package:bearnshare/domain/ledger/model/get_entries_response.dart';

class CreateEntryResponse {
  final bool success;
  final String message;
  final EntryItem data;
  final String? error;

  CreateEntryResponse({
    required this.success,
    required this.message,
    required this.data,
    this.error,
  });

  factory CreateEntryResponse.fromJson(Map<String, dynamic> json) {
    print(json['data']);
    print("tttttt");
    return CreateEntryResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json is String ? EntryItem.fromJson({}) : EntryItem.fromJson(json),
      error: json['error'],
    );
  }
}
