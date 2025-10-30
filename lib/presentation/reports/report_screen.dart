import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/presentation/component/app_progress_indicator.dart';
import 'package:bearnshare/presentation/reports/bloc/reports_bloc.dart';
import 'package:bearnshare/presentation/reports/bloc/reports_event.dart';
import 'package:bearnshare/presentation/reports/bloc/reports_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int selectedFilter = 0;
  final ScrollController _scrollController = ScrollController();

  final Map<int, String> periodMap = {
    0: 'this_month',
    1: '30_days',
    2: '60_days',
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ReportsBloc>().add(
          LoadReportSummary(period: periodMap[selectedFilter]!),
        );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<ReportsBloc>().add(const LoadMoreCategories());
    }
  }

  Future<void> _onRefresh() async {
    context.read<ReportsBloc>().add(
          LoadReportSummary(
            period: periodMap[selectedFilter]!,
            isRefresh: true,
          ),
        );
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: BlocBuilder<ReportsBloc, ReportsState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      const SizedBox(height: 20),
                      _buildFilterChips(),
                      const SizedBox(height: 20),
                      _buildSummaryCards(state),
                      const SizedBox(height: 24),
                      _buildTopSpendingHeader(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildCategoryList(state),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16),
            Text(
              'Reports',
              style: AppTheme.ledgerTitleTextStyle,
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {
            context.read<ReportsBloc>().add(const GetReportDownload());
          },
          icon: const Icon(Icons.file_download_outlined, size: 18),
          label: Text(
            'Download Pdf',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.reportBtnColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    final filters = ['This month', 'Last 30 Days', 'Last 60 Days'];

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppTheme.homePageCardBgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(filters.length, (index) {
          final isSelected = selectedFilter == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = index;
              });
              context.read<ReportsBloc>().add(
                    ChangePeriodFilter(periodMap[index]!),
                  );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                color:
                    isSelected ? AppTheme.reportTabActiveColor : Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                filters[index],
                style: AppTheme.profileTextStyle
                    .copyWith(color: Colors.white, fontSize: 12),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSummaryCards(ReportsState state) {
    if (state.status == ReportsStatus.loading && state.reportData == null) {
      return const SizedBox(
        height: 80,
        child: Center(child: AppProgressIndicator()),
      );
    }

    final totalIncome = state.reportData?.totalIncome ?? 0;
    final totalExpense = state.reportData?.totalExpense ?? 0;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.homePageCardBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xffE2FBE9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_upward,
                    color: Color(0xFF4CAF50),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Income',
                      style: AppTheme.historyTextStyle
                          .copyWith(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${totalIncome.toStringAsFixed(2)}',
                      style: AppTheme.homePageContentAmntTextStyle.copyWith(
                          fontSize: 16, color: AppTheme.amountPosTextColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.homePageCardBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xffFCEBEB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_downward,
                    color: Color(0xFFFF5252),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Expense',
                      style: AppTheme.historyTextStyle
                          .copyWith(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '₹${totalExpense.toStringAsFixed(2)}',
                      style: AppTheme.homePageContentAmntTextStyle.copyWith(
                          fontSize: 16, color: AppTheme.addExpenseBtnClr),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopSpendingHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Top Spending Categories',
          style: AppTheme.ledgerTitleTextStyle,
        ),
        /* Text(
          'View all',
          style: AppTheme.historyTextStyle,
        ),*/
      ],
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    final iconMap = {
      'groceries': Icons.shopping_basket,
      'transportation': Icons.directions_car,
      'entertainment': Icons.movie,
      'healthcare': Icons.favorite,
      'utilities': Icons.bolt,
      'food': Icons.restaurant,
      'shopping': Icons.shopping_bag,
      'travel': Icons.flight,
      'education': Icons.school,
      'other': Icons.category,
    };

    return iconMap[categoryName.toLowerCase()] ?? Icons.category;
  }

  Color _getCategoryIconBg(int index) {
    final colors = [
      const Color(0xFFFFEBEE),
      const Color(0xFFE3F2FD),
      const Color(0xFFF3E5F5),
      const Color(0xFFE8F5E9),
      const Color(0xFFFFF3E0),
      const Color(0xFFFCE4EC),
    ];
    return colors[index % colors.length];
  }

  Color _getCategoryIconColor(int index) {
    final colors = [
      const Color(0xFFFF5252),
      const Color(0xFF2196F3),
      const Color(0xFF9C27B0),
      const Color(0xFF4CAF50),
      const Color(0xFFFF9800),
      const Color(0xFFE91E63),
    ];
    return colors[index % colors.length];
  }

  Widget _buildCategoryList(ReportsState state) {
    if (state.status == ReportsStatus.loading &&
        state.displayedCategories.isEmpty) {
      return const Center(child: AppProgressIndicator());
    }

    if (state.displayedCategories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.pie_chart_outline,
              size: 64,
              color: AppTheme.searchTextColor.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No category data available',
              style: AppTheme.homePageContentHeaderTextStyle
                  .copyWith(color: AppTheme.searchTextColor, fontSize: 14),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount:
            state.displayedCategories.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.displayedCategories.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: AppProgressIndicator(),
              ),
            );
          }

          final category = state.displayedCategories[index];
          return _buildCategoryItem(
            icon: _getCategoryIcon(category.categoryName),
            iconBg: _getCategoryIconBg(index),
            iconColor: _getCategoryIconColor(index),
            name: category.categoryName,
            transactions: category.transactionCount,
            amount: category.totalAmount,
            percentage: category.percentage.toInt(),
          );
        },
      ),
    );
  }

  Widget _buildCategoryItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String name,
    required int transactions,
    required double amount,
    required int percentage,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTheme.ledgerTitleTextStyle,
                ),
                const SizedBox(height: 4),
                Text(
                  '$transactions transactions',
                  style: AppTheme.ledgerSearchTextStyle
                      .copyWith(color: AppTheme.genderInfoTextColor),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${amount.toStringAsFixed(0)}',
                style: AppTheme.homePageContentAmntTextStyle,
              ),
              const SizedBox(height: 4),
              Text(
                '$percentage% of total',
                style: AppTheme.ledgerSearchTextStyle
                    .copyWith(color: AppTheme.genderInfoTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
