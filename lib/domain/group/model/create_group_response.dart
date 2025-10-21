class CreateGroupResponse {
  final bool success;
  final String? message;
  final GroupData? data;

  CreateGroupResponse({
    required this.success,
    this.message,
    this.data,
  });

  factory CreateGroupResponse.fromJson(Map<String, dynamic> json) {
    return CreateGroupResponse(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null ? GroupData.fromJson(json['data']) : null,
    );
  }
}

class GroupData {
  final String id;
  final String name;
  final String description;
  final String currency;
  final List<String> memberUsernames;

  GroupData({
    required this.id,
    required this.name,
    required this.description,
    required this.currency,
    required this.memberUsernames,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) {
    return GroupData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      currency: json['currency'] ?? '',
      memberUsernames: List<String>.from(json['memberUsernames'] ?? []),
    );
  }
}
