class AddSplitRequest {
  final String description;
  final double totalAmount;
  final String currency;
  final String paidByUsername;
  final int? groupId;
  final String splitType;
  final List<SplitParticipant> participants;

  AddSplitRequest({
    required this.description,
    required this.totalAmount,
    required this.currency,
    required this.paidByUsername,
    required this.groupId,
    required this.splitType,
    required this.participants,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'totalAmount': totalAmount,
      'currency': currency,
      'paidByUsername': paidByUsername,
      'groupId': groupId,
      'splitType': splitType,
      'participants': participants.map((p) => p.toJson()).toList(),
    };
  }
}

class SplitParticipant {
  final String username;
  final double splitValue;

  SplitParticipant({
    required this.username,
    required this.splitValue,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'splitValue': splitValue,
    };
  }
}
