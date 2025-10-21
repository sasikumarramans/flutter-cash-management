import 'package:bearnshare/domain/ledger/model/get_books_response.dart';
import 'package:equatable/equatable.dart';

sealed class CreateBookEvent extends Equatable {
  const CreateBookEvent();

  @override
  List<Object?> get props => [];
}

class CreateBook extends CreateBookEvent {
  const CreateBook();
}

class BookNameChanged extends CreateBookEvent {
  final String name;
  const BookNameChanged(this.name);
}

class BookNameCompleted extends CreateBookEvent {
  final bool isValid;
  const BookNameCompleted({this.isValid = true});
}

class BookDescChanged extends CreateBookEvent {
  final String desc;
  const BookDescChanged(this.desc);
}

class EditBook extends CreateBookEvent {
  const EditBook();
}

class InitializeEditMode extends CreateBookEvent {
  final BooksItem bookItem;

  const InitializeEditMode({required this.bookItem});
}

class InitBook extends CreateBookEvent {
  const InitBook();
}
