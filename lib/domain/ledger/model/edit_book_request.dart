class EditBookRequest {
  final int id;
  final String name;
  final String description;
  final String currency;

  EditBookRequest({
    required this.id,
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
