class AddSplitResponse {
  final bool success;
  final String? message;
  final SplitData? data;

  AddSplitResponse({
    required this.success,
    this.message,
    this.data,
  });

  factory AddSplitResponse.fromJson(Map<String, dynamic> json) {
    return AddSplitResponse(
      success: json['success'] ?? false,
      message: json['message'],
      data: json['data'] != null ? SplitData.fromJson(json['data']) : null,
    );
  }
}

class SplitData {
  final String id;
  final String description;
  final double totalAmount;
  final String currency;
  final String paidByUsername;
  final int groupId;
  final String splitType;
  final List<SplitParticipantData> participants;

  SplitData({
    required this.id,
    required this.description,
    required this.totalAmount,
    required this.currency,
    required this.paidByUsername,
    required this.groupId,
    required this.splitType,
    required this.participants,
  });

  factory SplitData.fromJson(Map<String, dynamic> json) {
    return SplitData(
      id: json['id']?.toString() ?? '',
      description: json['description'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      currency: json['currency'] ?? '',
      paidByUsername: json['paidByUsername'] ?? '',
      groupId: json['groupId'] ?? 0,
      splitType: json['splitType'] ?? 'EQUAL',
      participants: (json['participants'] as List<dynamic>?)
              ?.map((p) => SplitParticipantData.fromJson(p))
              .toList() ??
          [],
    );
  }
}

class SplitParticipantData {
  final String username;
  final double splitValue;

  SplitParticipantData({
    required this.username,
    required this.splitValue,
  });

  factory SplitParticipantData.fromJson(Map<String, dynamic> json) {
    return SplitParticipantData(
      username: json['username'] ?? '',
      splitValue: (json['splitValue'] ?? 0).toDouble(),
    );
  }
}