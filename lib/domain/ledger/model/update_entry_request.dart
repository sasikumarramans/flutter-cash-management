class UpdateEntryRequest {
  final int id;
  final String type;
  final String name;
  final double amount;
  final String currency;
  final String dateTime;

  UpdateEntryRequest({
    required this.id,
    required this.type,
    required this.name,
    required this.amount,
    required this.currency,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'type': type,
        'name': name,
        'amount': amount,
        'currency': currency,
        'dateTime': dateTime,
      };
}
