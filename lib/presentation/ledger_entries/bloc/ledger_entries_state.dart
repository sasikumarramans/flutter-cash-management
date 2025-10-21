import 'package:equatable/equatable.dart';

enum CreateEntriesStatus {
  initial,
  loading,
  success,
  failed,
  deleteSuccess,
}

class LedgerEntriesState extends Equatable {
  final CreateEntriesStatus status;
  final int? currentBookId;
  final int? currentEntryId;
  final String name;
  final String amount;
  final String currency;
  final String dateTime;
  final String type;
  final bool isButtonEnabled;
  final bool isAmountEnabled;
  final bool isEditMode;

  const LedgerEntriesState({
    this.status = CreateEntriesStatus.initial,
    this.currentBookId,
    this.currentEntryId,
    this.name = '',
    this.amount = "0",
    this.currency = 'INR',
    this.dateTime = '',
    this.type = 'EXPENSE',
    this.isButtonEnabled = false,
    this.isEditMode = false,
    this.isAmountEnabled = false,
  });

  LedgerEntriesState copyWith({
    CreateEntriesStatus? status,
    int? currentBookId,
    int? currentEntryId,
    String? name,
    String? amount,
    String? currency,
    String? dateTime,
    String? type,
    bool? isButtonEnabled,
    bool? isEditMode,
    bool? isAmountEnabled,
  }) {
    return LedgerEntriesState(
      status: status ?? this.status,
      currentBookId: currentBookId ?? this.currentBookId,
      currentEntryId: currentEntryId ?? this.currentEntryId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      dateTime: dateTime ?? this.dateTime,
      type: type ?? this.type,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isEditMode: isEditMode ?? this.isEditMode,
      isAmountEnabled: isAmountEnabled ?? this.isAmountEnabled,
    );
  }

  @override
  List<Object?> get props => [
        status,
        currentBookId,
        currentEntryId,
        amount,
        name,
        currency,
        isButtonEnabled,
        isEditMode,
        dateTime,
        type,
        isAmountEnabled,
      ];
}
