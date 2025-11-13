import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/domain/friends/model/get_friends_response.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:bearnshare/presentation/split_friends/bloc/split_friends_bloc.dart';
import 'package:bearnshare/presentation/split_friends/bloc/split_friends_event.dart';
import 'package:bearnshare/presentation/split_friends/bloc/split_friends_state.dart';
import 'package:bearnshare/presentation/split_home/add_member_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SplitFriendsScreen extends StatefulWidget {
  const SplitFriendsScreen({super.key});

  @override
  State<SplitFriendsScreen> createState() => _SplitFriendsScreenState();
}

class _SplitFriendsScreenState extends State<SplitFriendsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final SplitFriendsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I.get<SplitFriendsBloc>();
    _bloc.add(const LoadFriends());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      _bloc.add(const LoadMoreFriends());
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildFilterTabs(),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0, left: 15),
                child: Text(
                  'Your Friends',
                  style: AppTheme.ledgerTitleTextStyle,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Expanded(
              child: _buildFriendsList(),
            ),
          ],
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
            'Friends',
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
          Assets.icons.friends.svg(color: Colors.white),
        ],
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
              hint: 'Search friends',
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
                _bloc.add(SearchFriendsChanged(value));
              },
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A3A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Assets.icons.filterIcon.svg(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return BlocBuilder<SplitFriendsBloc, SplitFriendsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: _buildTabButton('All', 0, state.selectedFilterIndex),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTabButton('Active', 1, state.selectedFilterIndex),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTabButton('Settled', 2, state.selectedFilterIndex),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabButton(String label, int index, int selectedTab) {
    final isSelected = selectedTab == index;
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
        _bloc.add(FilterFriendsChanged(index));
      },
    );
  }

  Widget _buildFriendsList() {
    return BlocBuilder<SplitFriendsBloc, SplitFriendsState>(
      builder: (context, state) {
        if (state.status == SplitFriendsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppTheme.splitGroupColor,
            ),
          );
        }

        if (state.status == SplitFriendsStatus.failed) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Failed to load friends',
                  style: AppTheme.ledgerTitleTextStyle,
                ),
                const SizedBox(height: 16),
                AppButton(
                  textString: 'Retry',
                  buttonType: ButtonType.filled,
                  buttonState: ButtonState.completed,
                  completedButtonFilledStyle: BoxDecoration(
                    color: AppTheme.splitGroupColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: (_) {
                    _bloc.add(const LoadFriends());
                  },
                ),
              ],
            ),
          );
        }

        if (state.filteredFriends.isEmpty) {
          return Center(
            child: Text(
              'No friends found',
              style: AppTheme.ledgerTitleTextStyle,
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            _bloc.add(const LoadFriends(isRefresh: true));
            await Future.delayed(const Duration(milliseconds: 500));
          },
          color: AppTheme.splitGroupColor,
          child: ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: state.filteredFriends.length,
            itemBuilder: (context, index) {
              if (index == state.filteredFriends.length + 1) {
                return state.isLoadingMore
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.splitGroupColor,
                          ),
                        ),
                      )
                    : const SizedBox(height: 100);
              }

              final friendIndex = index;
              final friend = state.filteredFriends[friendIndex];

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildFriendItem(friend),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildFriendItem(FriendItem friend) {
    String label;
    double amount;
    Color amountColor;

    if (friend.overallReceivingAmount > 0) {
      label = "You Receive";
      amount = friend.overallReceivingAmount;
      amountColor = const Color(0xFF4CAF50);
    } else if (friend.overallPayingAmount > 0) {
      label = 'You Pay';
      amount = friend.overallPayingAmount;
      amountColor = const Color(0xFFFF5252);
    } else if (friend.recentExpenses.isEmpty) {
      label = 'No expenses';
      amount = 0;
      amountColor = Colors.white54;
    } else {
      label = 'Settled';
      amount = 0;
      amountColor = Colors.white54;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.homePageCardBgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: const BoxDecoration(
                        color: Color(0xFFE3F2FD),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        friend.name.isNotEmpty
                            ? friend.name[0].toUpperCase()
                            : '?',
                        style: AppTheme.ledgerTitleTextStyle.copyWith(
                          fontSize: 24,
                          color: const Color(0xFF2196F3),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          friend.name.isNotEmpty
                              ? friend.name
                              : friend.username,
                          style: AppTheme.ledgerTitleTextStyle,
                        ),
                        Text(
                          "1 hour ago",
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
                if (friend.recentExpenses.isNotEmpty)
                  ...friend.recentExpenses.take(3).map(
                        (expense) => Padding(
                          padding: const EdgeInsets.only(bottom: 2, left: 60),
                          child: Text(
                            "${expense.status} INR ${expense.yourAmount} in ${expense.description}",
                            style: AppTheme.ledgerSearchTextStyle
                                .copyWith(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                else
                  Text(
                    'No recent expenses',
                    style: AppTheme.ledgerSearchTextStyle,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
