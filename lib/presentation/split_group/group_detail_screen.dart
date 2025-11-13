import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/domain/group/model/get_groups_response.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_bloc.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_event.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class GroupDetailScreen extends StatefulWidget {
  final GroupItem group;

  const GroupDetailScreen({
    super.key,
    required this.group,
  });

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  late final SplitGroupBloc _bloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I.get<SplitGroupBloc>();
    _bloc.add(LoadExpenses(widget.group.id));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      final state = _bloc.state;
      if (!state.isLoadingMoreExpenses && state.expensesHasMore) {
        _bloc.add(LoadMoreExpenses(widget.group.id));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: BlocBuilder<SplitGroupBloc, SplitGroupState>(
          builder: (context, state) {
            return Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildGroupInfo(state),
                        _buildActionButtons(),
                        _buildExpensesList(state),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppTheme.tertiaryBackgroundColor,
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 22),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: AppTheme.tertiaryBackgroundColor,
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.person_add, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupInfo(SplitGroupState state) {
    // Calculate total amount owed or to receive
    final totalAmount = state.expenses.fold<double>(
      0,
      (sum, expense) => sum + expense.currentUserAmount,
    );

    final isOwed = totalAmount > 0;
    final displayAmount = totalAmount.abs();

    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppTheme.splitGroupColor.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.group,
            color: AppTheme.splitGroupColor,
            size: 50,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          widget.group.name,
          style: AppTheme.homePageContentHeaderTextStyle.copyWith(
            fontSize: 28,
          ),
        ),
        Text(
          '${widget.group.memberCount} Members',
          style: AppTheme.historyTextStyle
              .copyWith(fontSize: 14, color: AppTheme.searchTextColor),
        ),
        const SizedBox(height: 5),
        if (totalAmount != 0)
          RichText(
            text: TextSpan(
              text: isOwed ? 'To Pay ' : 'You Receive ',
              style: AppTheme.historyTextStyle.copyWith(
                fontSize: 18,
              ),
              children: [
                TextSpan(
                  text: 'INR ${displayAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isOwed
                        ? AppTheme.amountNegTextColor
                        : AppTheme.amountPosTextColor,
                  ),
                ),
              ],
            ),
          )
        else
          Text(
            'All Settled Up!',
            style: AppTheme.historyTextStyle.copyWith(
              fontSize: 18,
              color: AppTheme.amountPosTextColor,
            ),
          ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              textString: 'Settle up',
              buttonType: ButtonType.filled,
              expandButton: true,
              onPressed: (_) {},
              enabledButtonFilledStyle: BoxDecoration(
                color: AppTheme.splitGroupColor,
                borderRadius: BorderRadius.circular(12),
              ),
              enabledTextStyle:
                  AppTheme.homePageContentHeaderTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              textString: 'Remind',
              buttonType: ButtonType.filled,
              expandButton: true,
              onPressed: (_) {},
              enabledButtonFilledStyle: BoxDecoration(
                color: AppTheme.homePageCardBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              enabledTextStyle:
                  AppTheme.homePageContentHeaderTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesList(SplitGroupState state) {
    if (state.expensesStatus == SplitGroupStatus.loading &&
        state.expenses.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: CircularProgressIndicator(
            color: AppTheme.splitGroupColor,
          ),
        ),
      );
    }

    if (state.expenses.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Text(
            'No expenses yet',
            style: AppTheme.historyTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount:
            state.expenses.length + (state.isLoadingMoreExpenses ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.expenses.length) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: CircularProgressIndicator(
                  color: AppTheme.splitGroupColor,
                ),
              ),
            );
          }

          final expense = state.expenses[index];
          final amountColor = expense.isOwed
              ? AppTheme.amountNegTextColor
              : AppTheme.amountPosTextColor;

          final iconColor = expense.isOwed
              ? AppTheme.amountNegTextColor
              : AppTheme.amountPosTextColor;

          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: AppTheme.homePageCardBgColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.receipt_long,
                      color: iconColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expense.description.isNotEmpty
                              ? expense.description
                              : 'Expense',
                          style:
                              AppTheme.homePageContentHeaderTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${expense.paidByUsername} paid ${expense.currency} ${expense.totalAmount.toStringAsFixed(2)}',
                          style: AppTheme.historyTextStyle.copyWith(
                              fontSize: 12, color: AppTheme.searchTextColor),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        expense.amountLabel,
                        style: AppTheme.historyTextStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${expense.currency} ${expense.currentUserAmount.abs().toStringAsFixed(2)}',
                        style: AppTheme.homePageContentAmntTextStyle.copyWith(
                          fontSize: 14,
                          color: amountColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
