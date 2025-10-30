import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/component/profile_avatar.dart';
import 'package:bearnshare/presentation/split_add/bloc/add_expense_split_bloc.dart';
import 'package:bearnshare/presentation/split_add/bloc/add_expense_split_event.dart';
import 'package:bearnshare/presentation/split_add/bloc/add_expense_split_state.dart';
import 'package:bearnshare/presentation/split_add/split_members_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AddExpenseSplitScreen extends StatefulWidget {
  final int groupId;

  const AddExpenseSplitScreen({
    super.key,
    required this.groupId,
  });

  @override
  State<AddExpenseSplitScreen> createState() => _AddExpenseSplitScreenState();
}

class _AddExpenseSplitScreenState extends State<AddExpenseSplitScreen> {
  final TextEditingController _amountController = TextEditingController();
  late final AddExpenseSplitBloc _bloc;
  final TextEditingController _descriptionController = TextEditingController();
  final Map<String, TextEditingController> _participantControllers = {};

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I.get<AddExpenseSplitBloc>();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    for (var controller in _participantControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  TextEditingController _getControllerForParticipant(
      String userId, double currentValue) {
    final controllerKey = '${userId}_${_bloc.state.splitType}';

    if (!_participantControllers.containsKey(controllerKey)) {
      _participantControllers[controllerKey] = TextEditingController(
        text: currentValue > 0 ? currentValue.toString() : '',
      );
    } else {
      // Update text based on current value
      final currentText = _participantControllers[controllerKey]!.text;
      final newText = currentValue > 0 ? currentValue.toString() : '';

      // Only update if the value is different and not being edited
      if (currentText != newText &&
          double.tryParse(currentText) != currentValue &&
          !_participantControllers[controllerKey]!.selection.isValid) {
        _participantControllers[controllerKey]!.text = newText;
      }
    }
    return _participantControllers[controllerKey]!;
  }

  String _getSplitTypeFromIndex(int index) {
    switch (index) {
      case 0:
        return 'EQUAL';
      case 1:
        return 'CUSTOM';
      case 2:
        return 'SHARES';
      case 3:
        return 'PERCENTAGE';
      default:
        return 'EQUAL';
    }
  }

  int _getIndexFromSplitType(String splitType) {
    switch (splitType) {
      case 'EQUAL':
        return 0;
      case 'PERCENTAGE':
        return 3;
      case 'SHARES':
        return 2;
      default:
        return 1;
    }
  }

  void _showAddMemberDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SplitMembersDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: BlocBuilder<AddExpenseSplitBloc, AddExpenseSplitState>(
          builder: (context, state) {
            return Column(
              children: [
                _buildHeader(),
                _buildAmountSection(state),
                _buildDescriptionField(state),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildSplitModeButtons(state),
                        _buildMembersList(state),
                      ],
                    ),
                  ),
                ),
                _buildActionButtons(context, state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDescriptionField(AddExpenseSplitState state) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: _descriptionController,
            textFieldStyle: TextFieldStyle.filled,
            textFieldState: TextFieldState.enabled,
            textFieldType: TextFieldType.text,
            hint: 'Enter description',
            maxLines: 3,
            onChanged: (value) {
              _bloc.add(DescriptionChanged(value));
            },
            padding: const EdgeInsets.all(16),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppTheme.tertiaryBackgroundColor,
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 22),
            ),
            onTap: () {
              context.pop();
            },
          ),
          const SizedBox(width: 12),
          Text(
            'Add Expense',
            style:
                AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection(AddExpenseSplitState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF28272D),
      ),
      child: Column(
        children: [
          Text(
            'Enter amount to split',
            style: AppTheme.homePageTitleTextStyle.copyWith(
              fontSize: 15,
              color: AppTheme.homePageSubtitleColor,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.homePageCardBgColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  children: [
                    Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, color: Colors.white, size: 24),
                  ],
                ),
              ),
              Flexible(
                child: IntrinsicWidth(
                  child: AppTextField(
                    controller: _amountController,
                    textFieldType: TextFieldType.mobile,
                    textAlign: TextAlign.center,
                    onValidation: (valid) => AmountValidationCompleted(valid),
                    textFieldStyle: TextFieldStyle.filled,
                    textFieldState: TextFieldState.enabled,
                    textStyle: AppTheme.homePageContentAmntTextStyle
                        .copyWith(fontSize: 36, color: Colors.white),
                    hint: '0.00',
                    filledEnabledStyle: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: AppTheme.homePageContentAmntTextStyle
                          .copyWith(fontSize: 36, color: Colors.grey),
                    ),
                    onChanged: (value) {
                      _bloc.add(AmountChanged(value));
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSplitModeButtons(AddExpenseSplitState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildModeButton(
            Assets.icons.splitScene
                .svg(height: 20, width: 20, fit: BoxFit.scaleDown),
            0,
            state,
          ),
          const SizedBox(width: 8),
          _buildModeButton(
            Assets.icons.split123
                .svg(height: 20, width: 20, fit: BoxFit.scaleDown),
            1,
            state,
          ),
          const SizedBox(width: 8),
          _buildModeButton(
            Assets.icons.splitChart
                .svg(height: 20, width: 20, fit: BoxFit.scaleDown),
            2,
            state,
          ),
          const SizedBox(width: 8),
          _buildModeButton(
            Assets.icons.splitPercentage
                .svg(height: 20, width: 20, fit: BoxFit.scaleDown),
            3,
            state,
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton(Widget icon, int index, AddExpenseSplitState state) {
    final selectedIndex = _getIndexFromSplitType(state.splitType);
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _bloc.add(SplitTypeChanged(_getSplitTypeFromIndex(index)));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.splitGroupColor
                : AppTheme.homePageCardBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: icon,
        ),
      ),
    );
  }

  Widget _buildMembersList(AddExpenseSplitState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.splitType == 'EQUAL'
                    ? 'Split equally'
                    : state.splitType == 'PERCENTAGE'
                        ? 'Split by percentages'
                        : state.splitType == 'SHARES'
                            ? 'Divide by shares'
                            : 'Split by custom amounts',
                style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
              ),
              if (widget.groupId == 0)
                GestureDetector(
                  onTap: () => _showAddMemberDialog(context),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.splitGroupColor.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Add',
                          style: AppTheme.ledgerTitleTextStyle.copyWith(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (state.participants.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  'No participants added yet.\nTap "Add" to add members.',
                  textAlign: TextAlign.center,
                  style: AppTheme.ledgerTitleTextStyle.copyWith(
                    fontSize: 14,
                    color: Colors.white54,
                  ),
                ),
              ),
            )
          else
            ...state.participants
                .map((participant) => _buildMemberItem(participant, state)),
        ],
      ),
    );
  }

  Widget _buildMemberItem(
      ParticipantWithSplit participant, AddExpenseSplitState state) {
    // Get the current value for this mode
    final currentValue = participant.getValueForMode(state.splitType);
    final controller = _getControllerForParticipant(
      participant.user.id,
      currentValue,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _bloc.add(ToggleParticipantSelection(participant.user.id));
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: participant.isSelected
                    ? AppTheme.splitGroupColor
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: participant.isSelected
                      ? AppTheme.splitGroupColor
                      : AppTheme.splitBorderLineColor,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 10,
              ),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 40,
            height: 40,
            child: ProfileAvatar(
              profilePicture: participant.user.profileImageUrl,
              name: participant.user.username,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              participant.user.username,
              style: AppTheme.homePageContentHeaderTextStyle
                  .copyWith(fontSize: 16),
            ),
          ),
          if (state.splitType == 'EQUAL')
            Text(
              state.amount.isNotEmpty
                  ? '${state.currency} ${participant.splitValue.toStringAsFixed(2)}'
                  : '${state.currency} 0.00',
              style: AppTheme.historyTextStyle.copyWith(fontSize: 16),
            )
          else
            SizedBox(
              width: state.splitType == 'CUSTOM' ? 120 : 100,
              child: Row(
                children: [
                  if (state.splitType == 'CUSTOM')
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Text(
                        '₹',
                        style: AppTheme.historyTextStyle.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      style: AppTheme.historyTextStyle.copyWith(fontSize: 16),
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white30),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white30),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppTheme.splitGroupColor),
                        ),
                        contentPadding: EdgeInsets.zero,
                        hintText: state.splitType == 'PERCENTAGE' ||
                                state.splitType == 'SHARES'
                            ? '0'
                            : '0.00',
                        hintStyle: AppTheme.historyTextStyle.copyWith(
                          fontSize: 16,
                          color: Colors.white54,
                        ),
                        suffixText: state.splitType == 'PERCENTAGE'
                            ? '%'
                            : state.splitType == 'SHARES'
                                ? ' share'
                                : '',
                        suffixStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (value) {
                        final amount = double.tryParse(value) ?? 0.00;
                        _bloc.add(UpdateParticipantSplitValue(
                          participant.user.id,
                          amount,
                        ));
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, AddExpenseSplitState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          AppButton(
            textString: 'Save',
            buttonType: ButtonType.filled,
            expandButton: true,
            buttonState:
                state.amount.isNotEmpty && state.participants.isNotEmpty
                    ? ButtonState.enabled
                    : ButtonState.disabled,
            onPressed: (_) {
              _bloc.add(AddSplit(widget.groupId));
            },
            enabledButtonFilledStyle: BoxDecoration(
              color: AppTheme.splitGroupColor,
              borderRadius: BorderRadius.circular(30),
            ),
            enabledTextStyle: AppTheme.loginText.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          ),
        ],
      ),
    );
  }
}
