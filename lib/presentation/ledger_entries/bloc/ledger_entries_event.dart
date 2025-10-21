import 'package:bearnshare/domain/ledger/model/get_entries_response.dart';
import 'package:equatable/equatable.dart';

sealed class LedgerEntriesEvent extends Equatable {
  const LedgerEntriesEvent();

  @override
  List<Object?> get props => [];
}

class CreateEntry extends LedgerEntriesEvent {
  const CreateEntry();
}

class EntriesNameChanged extends LedgerEntriesEvent {
  final String name;
  const EntriesNameChanged(this.name);
}

class EntriesNameCompleted extends LedgerEntriesEvent {
  final bool isValid;
  const EntriesNameCompleted({this.isValid = true});
}

class AmountChanged extends LedgerEntriesEvent {
  final String amount;
  const AmountChanged(this.amount);
}

class DateTimeChanged extends LedgerEntriesEvent {
  final String dateTime;
  const DateTimeChanged(this.dateTime);
}

class TypeChanged extends LedgerEntriesEvent {
  final String type;
  const TypeChanged(this.type);
}

class UpdateEntry extends LedgerEntriesEvent {
  const UpdateEntry();
}

class DeleteEntry extends LedgerEntriesEvent {
  final int entryId;
  const DeleteEntry(this.entryId);
}

class InitializeEntryEditMode extends LedgerEntriesEvent {
  final EntryItem entryItem;

  const InitializeEntryEditMode({required this.entryItem});
}

class InitializeBookForEntry extends LedgerEntriesEvent {
  final int bookId;
  final String entryType;

  const InitializeBookForEntry(
      {required this.bookId, this.entryType = 'EXPENSE'});
}
