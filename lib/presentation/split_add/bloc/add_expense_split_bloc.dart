import 'package:bearnshare/app/bloc/base/base_bloc.dart';
import 'package:bearnshare/app/helpers/app_snack_bar_manager.dart';
import 'package:bearnshare/app/router/router_manager.dart';
import 'package:bearnshare/domain/group/model/search_user_request.dart';
import 'package:bearnshare/domain/group/model/search_user_response.dart';
import 'package:bearnshare/domain/group/use_cases/search_users_use_case.dart';
import 'package:bearnshare/domain/split_add/model/add_split_request.dart';
import 'package:bearnshare/domain/split_add/model/add_split_response.dart';
import 'package:bearnshare/domain/split_add/use_cases/add_split_use_case.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_bloc.dart';
import 'package:bearnshare/presentation/split_add/bloc/add_expense_split_event.dart';
import 'package:bearnshare/presentation/split_add/bloc/add_expense_split_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class AddExpenseSplitBloc
    extends BaseBloc<AddExpenseSplitEvent, AddExpenseSplitState> {
  late final _addSplitUseCase = GetIt.I.get<AddSplitUseCase>();
  late final _searchUsersUseCase = GetIt.I.get<SearchUsersUseCase>();
  final _routerManager = GetIt.I.get<RouterManager>();
  CancelToken? _searchCancelToken;

  AddExpenseSplitBloc() : super(const AddExpenseSplitState()) {
    on<DescriptionChanged>(_onDescriptionChanged);
    on<AmountChanged>(_onAmountChanged);
    on<CurrencyChanged>(_onCurrencyChanged);
    on<PaidByChanged>(_onPaidByChanged);
    on<SplitTypeChanged>(_onSplitTypeChanged);
    on<SearchUsers>(_onSearchUsers);
    on<AddParticipant>(_onAddParticipant);
    on<RemoveParticipant>(_onRemoveParticipant);
    on<UpdateParticipantSplitValue>(_onUpdateParticipantSplitValue);
    on<ToggleParticipantSelection>(_onToggleParticipantSelection);
    on<DescriptionValidationCompleted>(_onDescriptionValidationCompleted);
    on<AmountValidationCompleted>(_onAmountValidationCompleted);
    on<AddSplit>(_onAddSplit);
    on<ClearSearchResults>(_onClearSearchResults);
  }

  @override
  Future<void> close() {
    _searchCancelToken?.cancel();
    return super.close();
  }

  void _onDescriptionChanged(
    DescriptionChanged event,
    Emitter<AddExpenseSplitState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  void _onAmountChanged(
    AmountChanged event,
    Emitter<AddExpenseSplitState> emit,
  ) {
    emit(state.copyWith(amount: event.amount));
    // Auto-recalculate for EQUAL and SHARES types
    if (state.splitType == 'EQUAL') {
      _recalculateEqualSplit(emit);
    } else if (state.splitType == 'SHARES') {
      _recalculateSharesSplit(emit);
    }
  }

  void _onCurrencyChanged(
    CurrencyChanged event,
    Emitter<AddExpenseSplitState> emit,
  ) {
    emit(state.copyWith(currency: event.currency));
  }

  void _onPaidByChanged(
    PaidByChanged event,
    Emitter<AddExpenseSplitState> emit,
  ) {
    emit(state.copyWith(paidBy: event.user));
  }

  void _onSplitTypeChanged(
    SplitTypeChanged event,
    Emitter<AddExpenseSplitState> emit,
  ) {
    emit(state.copyWith(splitType: event.splitType));

    // Recalculate split values only for EQUAL type
    // For CUSTOM, SHARES, and PERCENTAGE - keep user-entered values
    if (event.splitType == 'EQUAL') {
      _recalculateEqualSplit(emit);
    } else if (event.splitType == 'SHARES') {
      _recalculateSharesSplit(emit);
    }
  }

  void _onDescriptionValidationCompleted(
    DescriptionValidationCompleted event,
    Emitter<AddExpenseSplitState> emit,
  ) {
    emit(state.copyWith(isDescriptionValid: event.isValid));
  }

  void _onAmountValidationCompleted(
    AmountValidationCompleted event,
    Emitter<AddExpenseSplitState> emit,
  ) {
    emit(state.copyWith(isAmountValid: event.isValid));
  }

  Future<void> _onSearchUsers(
    SearchUsers event,
    Emitter<AddExpenseSplitState> emit,
  ) async {
    _searchCancelToken?.cancel();
    if (event.query.trim().isEmpty) {
      emit(state.copyWith(
        searchResults: [],
        searchStatus: SearchStatus.initial,
      ));
      return;
    }

    try {
      emit(state.copyWith(
        searchStatus: SearchStatus.loading,
        searchQuery: event.query,
      ));
      _searchCancelToken = CancelToken();
      final request = SearchUserRequest(query: event.query.trim());

      final response = await safeExecute<SearchUserResponse>(
        function: () async {
          return await _searchUsersUseCase.execute(
            request: request,
            cancelToken: _searchCancelToken,
          );
        },
        showLoading: false,
        showError: true,
      );

      if (response != null &&
          response.data != null &&
          response.data!.isNotEmpty) {
        emit(state.copyWith(
          searchResults: response.data,
          searchStatus: SearchStatus.success,
        ));
      } else {
        emit(state.copyWith(
          searchResults: [],
          searchStatus: SearchStatus.failed,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        searchResults: [],
        searchStatus: SearchStatus.failed,
      ));
    }
  }

  void _onAddParticipant(
    AddParticipant event,
    Emitter<AddExpenseSplitState> emit,
  ) {
    final isAlreadyAdded =
        state.participants.any((p) => p.user.id == event.user.id);

    if (!isAlreadyAdded) {
      final updatedParticipants = List<ParticipantWithSplit>.from(
        state.participants,
      )..add(ParticipantWithSplit(
          user: event.user,
          splitValue: 0,
          isSelected: true,
        ));

      emit(state.copyWith(participants: updatedParticipants));

      // Auto-calculate based on split type
      if (state.splitType == 'EQUAL') {
        _recalculateEqualSplit(emit);
      }
    }
  }

  void _onRemoveParticipant(
    RemoveParticipant event,
    Emitter<AddExpenseSplitState> emit,
  ) {
    final updatedParticipants =
        state.participants.where((p) => p.user.id != event.userId).toList();

    emit(state.copyWith(participants: updatedParticipants));

    // Recalculate if EQUAL split
    if (state.splitType == 'EQUAL') {
      _recalculateEqualSplit(emit);
    }
  }

  void _onToggleParticipantSelection(
    ToggleParticipantSelection event,
    Emitter<AddExpenseSplitState> emit,
  ) {
    final updatedParticipants = state.participants.map((p) {
      if (p.user.id == event.userId) {
        return p.copyWith(isSelected: !p.isSelected);
      }
      return p;
    }).toList();

    emit(state.copyWith(participants: updatedParticipants));

    // Recalculate based on split type
    if (state.splitType == 'EQUAL') {
      _recalculateEqualSplit(emit);
    } else if (state.splitType == 'PERCENTAGE') {
      _recalculatePercentageSplit(emit);
    }
  }

  void _onUpdateParticipantSplitValue(
    UpdateParticipantSplitValue event,
    Emitter<AddExpenseSplitState> emit,
  ) {
    final updatedParticipants = state.participants.map((p) {
      if (p.user.id == event.userId) {
        // Update the value for the current split mode
        switch (state.splitType) {
          case 'CUSTOM':
            return p.copyWith(customValue: event.splitValue);
          case 'SHARES':
            return p.copyWith(sharesValue: event.splitValue);
          case 'PERCENTAGE':
            return p.copyWith(percentageValue: event.splitValue);
          default:
            return p.copyWith(splitValue: event.splitValue);
        }
      }
      return p;
    }).toList();

    emit(state.copyWith(participants: updatedParticipants));
  }

  void _recalculateEqualSplit(Emitter<AddExpenseSplitState> emit) {
    if (state.amount.isEmpty || state.participants.isEmpty) return;

    final totalAmount = double.tryParse(state.amount) ?? 0;
    final selectedParticipants =
        state.participants.where((p) => p.isSelected).toList();

    if (selectedParticipants.isEmpty) return;

    final splitValue = totalAmount / selectedParticipants.length;

    final updatedParticipants = state.participants.map((p) {
      if (p.isSelected) {
        return p.copyWith(splitValue: splitValue);
      } else {
        return p.copyWith(splitValue: 0);
      }
    }).toList();

    emit(state.copyWith(participants: updatedParticipants));
  }

  void _recalculatePercentageSplit(Emitter<AddExpenseSplitState> emit) {
    if (state.amount.isEmpty || state.participants.isEmpty) return;

    final updatedParticipants = state.participants.map((p) {
      if (p.isSelected && p.splitValue > 0) {
        return p.copyWith(splitValue: p.splitValue); // Keep percentage as is
      }
      return p;
    }).toList();

    emit(state.copyWith(participants: updatedParticipants));
  }

  void _recalculateSharesSplit(Emitter<AddExpenseSplitState> emit) {
    if (state.amount.isEmpty || state.participants.isEmpty) return;

    final selectedParticipants =
        state.participants.where((p) => p.isSelected).toList();

    if (selectedParticipants.isEmpty) return;

    // Calculate total shares
    final totalShares = selectedParticipants.fold<double>(
      0,
      (sum, p) => sum + (p.splitValue > 0 ? p.splitValue : 0),
    );

    if (totalShares == 0) return;

    // Keep share values as entered by user
    final updatedParticipants = state.participants.map((p) {
      if (p.isSelected && p.splitValue > 0) {
        // Keep the share value as entered by user, don't recalculate
        return p;
      } else if (!p.isSelected) {
        return p.copyWith(splitValue: 0);
      }
      return p;
    }).toList();

    emit(state.copyWith(participants: updatedParticipants));
  }

  String? _validateSplit(List<ParticipantWithSplit> selectedParticipants) {
    if (selectedParticipants.isEmpty) {
      return 'Please select at least one participant';
    }

    switch (state.splitType) {
      case 'PERCENTAGE':
        final totalPercentage = selectedParticipants.fold<double>(
          0,
          (sum, p) => sum + p.percentageValue,
        );

        if ((totalPercentage - 100).abs() > 0.01) {
          return 'Total percentage must equal 100%. Currently: ${totalPercentage.toStringAsFixed(1)}%';
        }
        break;

      case 'CUSTOM':
        final totalCustomAmount = selectedParticipants.fold<double>(
          0,
          (sum, p) => sum + p.customValue,
        );
        final totalAmount = double.tryParse(state.amount) ?? 0;

        if ((totalCustomAmount - totalAmount).abs() > 0.01) {
          return 'Total split amount (₹${totalCustomAmount.toStringAsFixed(2)}) must equal the total amount (₹${totalAmount.toStringAsFixed(2)})';
        }
        break;

      case 'SHARES':
        final hasShares = selectedParticipants.any((p) => p.sharesValue > 0);
        if (!hasShares) {
          return 'Please enter share values for participants';
        }
        break;

      case 'EQUAL':
        break;
    }

    return null;
  }

  Future<void> _onAddSplit(
    AddSplit event,
    Emitter<AddExpenseSplitState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AddSplitStatus.loading, errorMessage: null));
      final selectedParticipants =
          state.participants.where((p) => p.isSelected).toList();

      // Validate split based on type
      final validationError = _validateSplit(selectedParticipants);
      if (validationError != null) {
        GetIt.I<AppSnackBarManager>().showError(validationError);
        emit(state.copyWith(
          status: AddSplitStatus.initial,
          errorMessage: validationError,
        ));
        return;
      }

      // Get the appropriate value based on split type
      final participants = selectedParticipants
          .map((p) => SplitParticipant(
                username: p.user.username,
                splitValue: p.getValueForMode(state.splitType),
              ))
          .toList();

      final request = AddSplitRequest(
        description: state.description,
        totalAmount: double.parse(state.amount),
        currency: "INR",
        paidByUsername:
            GetIt.I<ProfileBloc>().state.userDataObject?.username ?? "",
        groupId: event.groupId == 0 ? null : event.groupId,
        splitType: state.splitType,
        participants: participants,
      );

      final response = await safeExecute<AddSplitResponse>(
        function: () async {
          return await _addSplitUseCase.execute(request: request);
        },
        showLoading: true,
        showError: true,
      );

      if (response == null || !response.success) {
        emit(state.copyWith(
          status: AddSplitStatus.failed,
          errorMessage: response?.message ?? 'Failed to add split',
        ));
        return;
      }

      emit(state.copyWith(status: AddSplitStatus.success));
      _routerManager.goRouter.pop();
    } catch (e) {
      emit(state.copyWith(
        status: AddSplitStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onClearSearchResults(
    ClearSearchResults event,
    Emitter<AddExpenseSplitState> emit,
  ) {
    emit(state.copyWith(
      searchResults: [],
      searchStatus: SearchStatus.initial,
    ));
  }
}
