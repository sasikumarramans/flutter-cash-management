import 'package:bearnshare/domain/group/model/search_user_response.dart';
import 'package:equatable/equatable.dart';

enum AddSplitStatus {
  initial,
  loading,
  success,
  failed,
}

enum SearchStatus {
  initial,
  loading,
  success,
  failed,
}

class ParticipantWithSplit {
  final SearchUserData user;
  final double splitValue;
  final bool isSelected;
  final double customValue;
  final double sharesValue;
  final double percentageValue;

  ParticipantWithSplit({
    required this.user,
    required this.splitValue,
    this.isSelected = true,
    this.customValue = 0,
    this.sharesValue = 0,
    this.percentageValue = 0,
  });

  ParticipantWithSplit copyWith({
    SearchUserData? user,
    double? splitValue,
    bool? isSelected,
    double? customValue,
    double? sharesValue,
    double? percentageValue,
  }) {
    return ParticipantWithSplit(
      user: user ?? this.user,
      splitValue: splitValue ?? this.splitValue,
      isSelected: isSelected ?? this.isSelected,
      customValue: customValue ?? this.customValue,
      sharesValue: sharesValue ?? this.sharesValue,
      percentageValue: percentageValue ?? this.percentageValue,
    );
  }

  double getValueForMode(String splitType) {
    switch (splitType) {
      case 'CUSTOM':
        return customValue;
      case 'SHARES':
        return sharesValue;
      case 'PERCENTAGE':
        return percentageValue;
      default:
        return splitValue;
    }
  }
}

class AddExpenseSplitState extends Equatable {
  final String description;
  final String amount;
  final String currency;
  final SearchUserData? paidBy;
  final String splitType; // EQUAL, PERCENTAGE, CUSTOM
  final List<ParticipantWithSplit> participants;
  final String? searchQuery;
  final List<SearchUserData> searchResults;
  final SearchStatus searchStatus;
  final AddSplitStatus status;
  final String? errorMessage;
  final bool isDescriptionValid;
  final bool isAmountValid;

  const AddExpenseSplitState({
    this.description = '',
    this.amount = '',
    this.currency = '₹',
    this.paidBy,
    this.splitType = 'EQUAL',
    this.participants = const [],
    this.searchQuery = '',
    this.searchResults = const [],
    this.searchStatus = SearchStatus.initial,
    this.status = AddSplitStatus.initial,
    this.errorMessage,
    this.isDescriptionValid = false,
    this.isAmountValid = false,
  });

  AddExpenseSplitState copyWith({
    String? description,
    String? amount,
    String? currency,
    SearchUserData? paidBy,
    String? splitType,
    List<ParticipantWithSplit>? participants,
    String? searchQuery,
    List<SearchUserData>? searchResults,
    SearchStatus? searchStatus,
    AddSplitStatus? status,
    String? errorMessage,
    bool? isDescriptionValid,
    bool? isAmountValid,
  }) {
    return AddExpenseSplitState(
      description: description ?? this.description,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      paidBy: paidBy ?? this.paidBy,
      splitType: splitType ?? this.splitType,
      participants: participants ?? this.participants,
      searchQuery: searchQuery ?? this.searchQuery,
      searchResults: searchResults ?? this.searchResults,
      searchStatus: searchStatus ?? this.searchStatus,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isDescriptionValid: isDescriptionValid ?? this.isDescriptionValid,
      isAmountValid: isAmountValid ?? this.isAmountValid,
    );
  }

  @override
  List<Object?> get props => [
        description,
        amount,
        currency,
        paidBy,
        splitType,
        participants,
        searchQuery,
        searchResults,
        searchStatus,
        status,
        errorMessage,
        isDescriptionValid,
        isAmountValid,
      ];
}
