extension StringUtil on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isEmail =>
      RegExp(r'^[a-zA-Z0-9.+]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(this ?? '');

  String get removeSpaces => this?.replaceAll(' ', '').toUpperCase() ?? '';

  DateTime get convertStringToDateTime => DateTime.parse(this ?? '');

  String get toCapitalized {
    return isNullOrEmpty
        ? ''
        : '${this?[0].toUpperCase()}${this?.substring(1).toLowerCase()}';
  }

  bool notContains(String value) => !(this?.contains(value) ?? false);

  String get normalizedEmail => this?.trim().toLowerCase() ?? '';
}
