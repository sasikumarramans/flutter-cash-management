import 'package:equatable/equatable.dart';

enum CreateBookStatus {
  initial,
  loading,
  success,
  failed,
}

class CreateBookState extends Equatable {
  final CreateBookStatus status;
  final int? currentBookId;
  final String bookName;
  final String bookDescription;
  final String currency;
  final bool isButtonEnabled;
  final bool isEditMode;

  const CreateBookState({
    this.status = CreateBookStatus.initial,
    this.currentBookId,
    this.bookDescription = '',
    this.bookName = '',
    this.currency = 'INR',
    this.isButtonEnabled = false,
    this.isEditMode = false,
  });

  CreateBookState copyWith({
    CreateBookStatus? status,
    int? currentBookId,
    String? bookDescription,
    String? bookName,
    String? currency,
    bool? isButtonEnabled,
    bool? isEditMode,
  }) {
    return CreateBookState(
      status: status ?? this.status,
      currentBookId: currentBookId ?? this.currentBookId,
      bookName: bookName ?? this.bookName,
      bookDescription: bookDescription ?? this.bookDescription,
      currency: currency ?? this.currency,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }

  @override
  List<Object?> get props => [
        status,
        currentBookId,
        bookDescription,
        bookName,
        currency,
        isButtonEnabled,
        isEditMode,
      ];
}
