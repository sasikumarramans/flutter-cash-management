class CreateGroupRequest {
  final String name;
  final String description;
  final String currency;
  final List<String> memberUsernames;

  CreateGroupRequest({
    required this.name,
    required this.description,
    required this.currency,
    required this.memberUsernames,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'currency': currency,
      'memberUsernames': memberUsernames,
    };
  }
}
