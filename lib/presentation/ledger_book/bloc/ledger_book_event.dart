import 'package:bearnshare/domain/ledger/model/get_books_response.dart';
import 'package:bearnshare/domain/ledger/model/get_entries_response.dart';
import 'package:equatable/equatable.dart';

sealed class LedgerBookEvent extends Equatable {
  const LedgerBookEvent();

  @override
  List<Object?> get props => [];
}

class LoadEntries extends LedgerBookEvent {
  final int bookId;
  final bool isRefresh;
  const LoadEntries({required this.bookId, this.isRefresh = false});
}

class LoadMoreEntries extends LedgerBookEvent {
  const LoadMoreEntries();
}

class SearchEntriesChanged extends LedgerBookEvent {
  final String query;
  const SearchEntriesChanged(this.query);
}

class LoadBooks extends LedgerBookEvent {
  final bool isRefresh;
  const LoadBooks({this.isRefresh = false});
}

class LoadMoreBooks extends LedgerBookEvent {
  const LoadMoreBooks();
}

class SearchBooksChanged extends LedgerBookEvent {
  final String query;
  const SearchBooksChanged(this.query);
}

class SelectedBook extends LedgerBookEvent {
  final BooksItem booksItem;
  const SelectedBook(this.booksItem);
}

class DeleteBook extends LedgerBookEvent {
  final int bookId;
  const DeleteBook(this.bookId);
}

class KeyboardVisibilityChanged extends LedgerBookEvent {
  final bool isKeyBoardVisible;
  const KeyboardVisibilityChanged(this.isKeyBoardVisible);
}

class LedgerDeleteEntry extends LedgerBookEvent {
  final int entryId;
  const LedgerDeleteEntry(this.entryId);
}

class UpdateEntryItem extends LedgerBookEvent {
  final EntryItem updatedEntry;
  const UpdateEntryItem(this.updatedEntry);
}

class InsertEntryItem extends LedgerBookEvent {
  final EntryItem newEntry;
  const InsertEntryItem(this.newEntry);
}

class UpdateBookItem extends LedgerBookEvent {
  final BooksItem updatedBook;
  const UpdateBookItem(this.updatedBook);

  @override
  List<Object?> get props => [updatedBook];
}

class InsertBookItem extends LedgerBookEvent {
  final BooksItem newBook;
  const InsertBookItem(this.newBook);
}

class GetBookById extends LedgerBookEvent {
  const GetBookById();
}

class LoadRecentBooks extends LedgerBookEvent {
  const LoadRecentBooks();
}

class LoadDashboard extends LedgerBookEvent {
  final double goalAmount;
  const LoadDashboard({this.goalAmount = 100000});

  @override
  List<Object?> get props => [goalAmount];
}
