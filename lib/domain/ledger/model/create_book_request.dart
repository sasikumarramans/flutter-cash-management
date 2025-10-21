class CreateBookRequest {
  final String name;
  final String description;
  final String currency;

  CreateBookRequest({
    required this.name,
    required this.description,
    required this.currency,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'currency': currency,
      };
}
