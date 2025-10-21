import 'package:bearnshare/domain/ledger/model/get_books_response.dart';

class CreateBookResponse {
  final BooksItem data;

  CreateBookResponse({
    required this.data,
  });

  factory CreateBookResponse.fromJson(Map<String, dynamic> json) {
    return CreateBookResponse(
      data: BooksItem.fromJson(json),
    );
  }
}
