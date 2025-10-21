class CreateEntryRequest {
  final int bookId;
  final String type;
  final String name;
  final double amount;
  final String currency;
  final String dateTime;

  CreateEntryRequest({
    required this.bookId,
    required this.type,
    required this.name,
    required this.amount,
    required this.currency,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
        'bookId': bookId,
        'type': type,
        'name': name,
        'amount': amount,
        'currency': currency,
        'dateTime': dateTime,
      };
}
