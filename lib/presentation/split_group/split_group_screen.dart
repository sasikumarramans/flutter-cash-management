import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/domain/group/model/get_groups_response.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_bloc.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_event.dart';
import 'package:bearnshare/presentation/split_group/bloc/split_group_state.dart';
import 'package:bearnshare/presentation/split_home/add_member_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SplitGroupScreen extends StatefulWidget {
  const SplitGroupScreen({super.key});

  @override
  State<SplitGroupScreen> createState() => _SplitGroupScreenState();
}

class _SplitGroupScreenState extends State<SplitGroupScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final SplitGroupBloc _bloc;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I.get<SplitGroupBloc>();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    BackButtonInterceptor.add(myInterceptor);
    _bloc.add(const LoadGroups());
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      _bloc.add(const LoadMoreGroups());
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    context.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SplitGroupBloc, SplitGroupState>(
          bloc: _bloc,
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                _buildHeader(),
                _buildFilterTabs(state),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: _buildGroupsList(state),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 70),
        child: AppButton(
          textString: 'Add Expense',
          buttonType: ButtonType.filled,
          buttonState: ButtonState.completed,
          leadingIcon: const Icon(Icons.add, color: Colors.white, size: 20),
          completedButtonFilledStyle: BoxDecoration(
            color: AppTheme.splitGroupColor,
            borderRadius: BorderRadius.circular(30),
          ),
          completedTextStyle: AppTheme.bottomBarText.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          onPressed: (_) {
            AddExpenseMembersSheet.showAddExpenseMembersDialog(context);
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const SizedBox(width: 5),
          Text(
            'Group',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 20),
          ),
          const Spacer(),
          GestureDetector(
            child: Assets.icons.graph.svg(color: Colors.white),
            onTap: () {
              context.pushNamed(MainRouter.splitReportSummaryRoute);
            },
          ),
          const SizedBox(width: 16),
          GestureDetector(
            child: Assets.icons.group.svg(color: Colors.white),
            onTap: () {
              context.pushNamed(MainRouter.splitCreateGroupRoute);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCreateGroupCard() {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            height: 200,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create a Group',
                          style: AppTheme.ledgerTitleTextStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Start splitting expenses with friends',
                      style: AppTheme.promptTextStyle.copyWith(
                          fontSize: 12, color: AppTheme.genderInfoTextColor),
                    ),
                    const SizedBox(height: 10),
                    AppButton(
                      textString: 'Create group',
                      buttonType: ButtonType.filled,
                      buttonState: ButtonState.completed,
                      leadingIcon: Assets.icons.group.svg(),
                      completedButtonFilledStyle: BoxDecoration(
                        color: AppTheme.splitGroupColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      completedTextStyle: AppTheme.bottomBarText.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      onPressed: (_) async {
                        await context
                            .pushNamed(MainRouter.splitCreateGroupRoute);
                        _bloc.add(const LoadGroups());
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          onTap: () async {
            await context.pushNamed(MainRouter.splitCreateGroupRoute);
            _bloc.add(const LoadGroups());
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: AppTextField(
              controller: _searchController,
              hint: 'Search transactions',
              textFieldStyle: TextFieldStyle.filled,
              textFieldState: TextFieldState.enabled,
              textFieldType: TextFieldType.text,
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white54,
                size: 22,
              ),
              hintStyle: AppTheme.ledgerSearchTextStyle,
              textStyle: AppTheme.simpleWhiteTextStyle,
              onChanged: (value) {
                // Handle search
              },
            ),
          ),
          /* const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A3A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Assets.icons.filterIcon.svg(),
          ),*/
        ],
      ),
    );
  }

  Widget _buildFilterTabs(SplitGroupState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton('All Group', 0, state),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildTabButton('Active', 1, state),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildTabButton('Settled', 2, state),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index, SplitGroupState state) {
    final isSelected = state.selectedFilterIndex == index;
    return AppButton(
      textString: label,
      buttonType: ButtonType.filled,
      buttonState: isSelected ? ButtonState.completed : ButtonState.enabled,
      expandButton: true,
      enabledButtonFilledStyle: BoxDecoration(
        color: AppTheme.homePageCardBgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      completedButtonFilledStyle: BoxDecoration(
        color: AppTheme.splitGroupColor,
        borderRadius: BorderRadius.circular(10),
      ),
      enabledTextStyle: AppTheme.bottomBarText.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
      completedTextStyle: AppTheme.bottomBarText.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      onPressed: (_) {
        _bloc.add(FilterGroupsChanged(index));
      },
    );
  }

  Widget _buildGroupsList(SplitGroupState state) {
    if (state.groups.isEmpty) {
      return _buildCreateGroupCard();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Your Groups',
            style: AppTheme.ledgerTitleTextStyle,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              _bloc.add(const LoadGroups(isRefresh: true));
              await Future.delayed(const Duration(milliseconds: 500));
            },
            color: AppTheme.splitGroupColor,
            child: ListView.builder(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: state.groups.length + 1, // +1 for loading indicator
              itemBuilder: (context, index) {
                if (index == state.groups.length) {
                  return state.isLoadingMore
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.splitGroupColor,
                            ),
                          ),
                        )
                      : const SizedBox(height: 100);
                }

                final group = state.groups[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildGroupItem(group: group),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGroupItem({required GroupItem group}) {
    // Determine icon based on group type
    String label;
    double amount;
    Color amountColor;

    if (group.overallReceivingAmount > 0) {
      label = "You Receive";
      amount = group.overallReceivingAmount;
      amountColor = const Color(0xFF4CAF50);
    } else if (group.overallPayingAmount > 0) {
      label = 'You Pay';
      amount = group.overallPayingAmount;
      amountColor = const Color(0xFFFF5252);
    } else if (group.recentExpenses.isEmpty) {
      label = 'No expenses';
      amount = 0;
      amountColor = Colors.white54;
    } else {
      label = 'Settled';
      amount = 0;
      amountColor = Colors.white54;
    }
    IconData icon = Icons.group;
    Color iconBg = const Color(0xFFE3F2FD);
    Color iconColor = const Color(0xFF2196F3);

    switch (group.type.toLowerCase()) {
      case 'home':
        icon = Icons.home;
        iconBg = const Color(0xFFF3E5F5);
        iconColor = const Color(0xFF9C27B0);
        break;
      case 'trip':
        icon = Icons.flight;
        iconBg = const Color(0xFFE3F2FD);
        iconColor = const Color(0xFF2196F3);
        break;
      case 'work':
        icon = Icons.work;
        iconBg = const Color(0xFFFFF3E0);
        iconColor = const Color(0xFFFF9800);
        break;
      default:
        icon = Icons.group;
    }

    // Format time
    final createdAt = DateTime.tryParse(group.createdAt);
    String timeAgo = 'Unknown';
    if (createdAt != null) {
      final difference = DateTime.now().difference(createdAt);
      if (difference.inDays > 0) {
        timeAgo =
            '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        timeAgo =
            '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        timeAgo =
            '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else {
        timeAgo = 'Just now';
      }
    }

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.homePageCardBgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: AppTheme.ledgerTitleTextStyle,
                    ),
                    Text(
                      timeAgo,
                      style: AppTheme.ledgerSearchTextStyle,
                    ),
                  ],
                )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: AppTheme.ledgerSearchTextStyle
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      amount > 0 ? '₹${amount.toStringAsFixed(2)}' : '₹0',
                      style: AppTheme.homePageContentAmntTextStyle.copyWith(
                        fontSize: 16,
                        color: amountColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.id == 0
                      ? '${group.memberCount} expenses'
                      : '${group.memberCount} members',
                  style: AppTheme.ledgerSearchTextStyle
                      .copyWith(fontSize: 12, color: Colors.white54),
                ),
                if (group.recentExpenses.isNotEmpty)
                  ...group.recentExpenses.take(3).map(
                        (expense) => Padding(
                          padding: const EdgeInsets.only(bottom: 2, left: 0),
                          child: Text(
                            "${expense.status} INR ${expense.yourAmount} in ${expense.description}",
                            style: AppTheme.ledgerSearchTextStyle
                                .copyWith(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        context.pushNamed(MainRouter.groupDetailRoute,
            extra: {"groupItem": group});
      },
    );
  }
}
