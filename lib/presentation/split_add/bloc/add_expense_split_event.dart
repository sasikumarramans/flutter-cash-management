import 'package:bearnshare/domain/group/model/search_user_response.dart';
import 'package:equatable/equatable.dart';

sealed class AddExpenseSplitEvent extends Equatable {
  const AddExpenseSplitEvent();

  @override
  List<Object?> get props => [];
}

class DescriptionChanged extends AddExpenseSplitEvent {
  final String description;
  const DescriptionChanged(this.description);
}

class AmountChanged extends AddExpenseSplitEvent {
  final String amount;
  const AmountChanged(this.amount);
}

class CurrencyChanged extends AddExpenseSplitEvent {
  final String currency;
  const CurrencyChanged(this.currency);
}

class PaidByChanged extends AddExpenseSplitEvent {
  final SearchUserData user;
  const PaidByChanged(this.user);
}

class SplitTypeChanged extends AddExpenseSplitEvent {
  final String splitType;
  const SplitTypeChanged(this.splitType);
}

class SearchUsers extends AddExpenseSplitEvent {
  final String query;
  const SearchUsers(this.query);
}

class AddParticipant extends AddExpenseSplitEvent {
  final SearchUserData user;
  const AddParticipant(this.user);
}

class RemoveParticipant extends AddExpenseSplitEvent {
  final String userId;
  const RemoveParticipant(this.userId);
}

class UpdateParticipantSplitValue extends AddExpenseSplitEvent {
  final String userId;
  final double splitValue;
  const UpdateParticipantSplitValue(this.userId, this.splitValue);
}

class ToggleParticipantSelection extends AddExpenseSplitEvent {
  final String userId;
  const ToggleParticipantSelection(this.userId);
}

class DescriptionValidationCompleted extends AddExpenseSplitEvent {
  final bool isValid;
  const DescriptionValidationCompleted(this.isValid);
}

class AmountValidationCompleted extends AddExpenseSplitEvent {
  final bool isValid;
  const AmountValidationCompleted(this.isValid);
}

class AddSplit extends AddExpenseSplitEvent {
  final int groupId;
  const AddSplit(this.groupId);
}

class ClearSearchResults extends AddExpenseSplitEvent {
  const ClearSearchResults();
}

class InitializeParticipants extends AddExpenseSplitEvent {
  final List<SearchUserData> participants;
  final int groupId;
  const InitializeParticipants(this.participants, this.groupId);
}
