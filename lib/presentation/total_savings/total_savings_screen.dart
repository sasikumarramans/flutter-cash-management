import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/presentation/component/app_bottom_nav_bar.dart';
import 'package:bearnshare/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:bearnshare/presentation/dashboard/bloc/dashboard_event.dart';
import 'package:bearnshare/presentation/dashboard/dash_board_router.dart';
import 'package:bearnshare/presentation/history/bloc/ledger_history_bloc.dart';
import 'package:bearnshare/presentation/history/bloc/ledger_history_event.dart';
import 'package:bearnshare/presentation/history/bloc/ledger_history_state.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_bloc.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_event.dart';
import 'package:bearnshare/presentation/ledger_book/bloc/ledger_book_state.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TotalSavingsScreen extends StatefulWidget {
  const TotalSavingsScreen({super.key});

  @override
  State<TotalSavingsScreen> createState() => _TotalSavingsScreenState();
}

class _TotalSavingsScreenState extends State<TotalSavingsScreen> {
  @override
  void initState() {
    super.initState();
    GetIt.I<LedgerBookBloc>().add(const LoadDashboard());
    GetIt.I<LedgerHistoryBloc>().add(const LoadHistoryRecentEntries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<LedgerBookBloc, LedgerBookState>(
            builder: (context, state) {
          return Column(
            children: [
              _buildHeader(),
              _buildSavingsBanner(state),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildStatsCards(state),
                    const SizedBox(height: 16),
                    _buildRecentEntriesHeader(),
                  ],
                ),
              ),
              Expanded(
                child: _buildRecentEntries(state),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(
            MainRouter.addIncomeRoute,
            extra: {
              'bookId':
                  GetIt.I.get<LedgerBookBloc>().state.selectedBookItem?.id,
              'entryType': 'INCOME',
            },
          );
        },
        backgroundColor: AppTheme.amountPosTextColor,
        child: const Icon(Icons.add, size: 32, color: Colors.white),
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
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          Text(
            'Total Savings',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 18),
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.more_vert, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsBanner(LedgerBookState state) {
    final createdAt = DateTime.now();
    String formattedDate = DateFormat('MMM dd, yyyy').format(createdAt);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00573C), Color(0xFF0A3420)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.savings,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'As of today',
                    style: AppTheme.promptTextStyle.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    formattedDate,
                    style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '₹${state.dashboardData?.totalSavings ?? 0}',
            style: AppTheme.homePageContentAmntTextStyle.copyWith(fontSize: 32),
          ),
          Text(
            'Total Savings',
            style: AppTheme.promptTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.arrow_upward, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                '+' +
                    '₹${state.dashboardData?.totalSavings ?? 0}' +
                    "  this month |",
                style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
              ),
              const SizedBox(width: 12),
              Text(
                "${state.dashboardData?.goalProgress ?? 0}% of goal",
                style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards(LedgerBookState state) {
    const double goalAmount = 100000;
    final double totalSavings = state.dashboardData?.totalSavings ?? 0;
    final double thisMonthSavings = state.dashboardData?.thisMonthSavings ?? 0;

    // Calculate remaining amount to reach goal
    final double remainingAmount = goalAmount - totalSavings;
    final String remainingText = remainingAmount > 0
        ? '₹${remainingAmount.toStringAsFixed(0)} to go'
        : 'Goal reached!';

    // Calculate this month's savings as percentage of goal
    final double thisMonthPercentage = (thisMonthSavings / goalAmount) * 100;
    final String thisMonthPercentageText = thisMonthPercentage > 0
        ? '+${thisMonthPercentage.toStringAsFixed(1)}%'
        : '0%';

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.homePageCardBgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppTheme.tertiaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'This Month',
                      style:
                          AppTheme.ledgerSearchTextStyle.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '+₹${state.dashboardData?.thisMonthSavings ?? 0}',
                  style: AppTheme.homePageContentAmntTextStyle
                      .copyWith(fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(
                  thisMonthPercentageText,
                  style: AppTheme.ledgerSearchTextStyle
                      .copyWith(color: const Color(0xFF4CAF50), fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.homePageCardBgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4B83EE),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Goal Progress',
                      style:
                          AppTheme.ledgerSearchTextStyle.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  "${state.dashboardData?.goalProgress ?? 0}%",
                  style: AppTheme.homePageContentAmntTextStyle
                      .copyWith(fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(
                  remainingText,
                  style: AppTheme.ledgerSearchTextStyle
                      .copyWith(color: const Color(0xFF4B83EE), fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentEntriesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Entries',
          style: AppTheme.ledgerTitleTextStyle,
        )

        /*Row(
          children: [
            Assets.icons.filterIcon.svg(),
            const SizedBox(width: 6),
            Text(
              'Filters',
              style: AppTheme.ledgerSearchTextStyle
                  .copyWith(color: Colors.white, fontSize: 16),
            ),
          ],
        ),*/
      ],
    );
  }

  Widget _buildRecentEntries(LedgerBookState state) {
    return BlocBuilder<LedgerHistoryBloc, LedgerHistoryState>(
        builder: (context, state) {
      return state.recentEntries.isNotEmpty
          ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: state.recentEntries.length + 1,
              itemBuilder: (context, index) {
                if (index == state.recentEntries.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 16),
                    child: _buildViewAllButton(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildEntryItem(
                    icon: state.recentEntries[index].type == "EXPENSE"
                        ? Icons.remove
                        : Icons.add,
                    iconBg: state.recentEntries[index].type == "EXPENSE"
                        ? const Color(0xFFFFEBEE)
                        : const Color(0xFFE8F5E9),
                    iconColor: state.recentEntries[index].type == "EXPENSE"
                        ? const Color(0xFFFF5252)
                        : const Color(0xFF4CAF50),
                    title: state.recentEntries[index].title,
                    date: state.recentEntries[index].dateTime ?? "",
                    amount: (state.recentEntries[index].amount ?? 0).toString(),
                    amountColor: state.recentEntries[index].type == "EXPENSE"
                        ? AppTheme.addExpenseBtnClr
                        : AppTheme.tertiaryColor,
                    tag: state.recentEntries[index].type,
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 30,
                    color: AppTheme.searchTextColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No entries found',
                    style: AppTheme.homePageContentHeaderTextStyle.copyWith(
                        color: AppTheme.searchTextColor, fontSize: 14),
                  ),
                ],
              ),
            );
    });
  }

  Widget _buildEntryItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String date,
    required String amount,
    required Color amountColor,
    required String tag,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.homePageCardBgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: AppTheme.ledgerSearchTextStyle
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: amountColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                tag,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildViewAllButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          GetIt.I<DashboardBloc>()
              .add(const DashboardTabChanged(BottomNavItem.history));
          context.go(DashboardRouter.historyRoute);
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          'View All Entries',
          style: AppTheme.homePageTitleTextStyle,
        ),
      ),
    );
  }
}
