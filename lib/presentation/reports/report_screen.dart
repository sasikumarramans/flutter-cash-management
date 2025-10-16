import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
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
                  _buildSummaryCards(),
                  const SizedBox(height: 24),
                  _buildTopSpendingHeader(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Expanded(
              child: _buildCategoryList(),
            ),
          ],
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
          onPressed: () {},
          icon: const Icon(Icons.file_download_outlined, size: 18),
          label: Text(
            'Download Pdf',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A90E2),
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

  Widget _buildSummaryCards() {
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
                      '₹3,200',
                      style: AppTheme.homePageContentAmntTextStyle.copyWith(
                          fontSize: 18, color: AppTheme.amountPosTextColor),
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
                      '₹3,200',
                      style: AppTheme.homePageContentAmntTextStyle.copyWith(
                          fontSize: 18, color: AppTheme.addExpenseBtnClr),
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
        Text(
          'View all',
          style: AppTheme.historyTextStyle,
        ),
      ],
    );
  }

  Widget _buildCategoryList() {
    final categories = [
      CategoryData(
        icon: Icons.shopping_basket,
        iconBg: const Color(0xFFFFEBEE),
        iconColor: const Color(0xFFFF5252),
        name: 'Groceries',
        transactions: 15,
        amount: 2500,
        percentage: 34,
      ),
      CategoryData(
        icon: Icons.directions_car,
        iconBg: const Color(0xFFE3F2FD),
        iconColor: const Color(0xFF2196F3),
        name: 'Transportation',
        transactions: 8,
        amount: 890,
        percentage: 24,
      ),
      CategoryData(
        icon: Icons.movie,
        iconBg: const Color(0xFFF3E5F5),
        iconColor: const Color(0xFF9C27B0),
        name: 'Entertainment',
        transactions: 6,
        amount: 520,
        percentage: 14,
      ),
      CategoryData(
        icon: Icons.favorite,
        iconBg: const Color(0xFFE8F5E9),
        iconColor: const Color(0xFF4CAF50),
        name: 'Healthcare',
        transactions: 3,
        amount: 500,
        percentage: 34,
      ),
      CategoryData(
        icon: Icons.bolt,
        iconBg: const Color(0xFFFFEBEE),
        iconColor: const Color(0xFFFF5252),
        name: 'Utilities',
        transactions: 4,
        amount: 2500,
        percentage: 10,
      ),
      CategoryData(
        icon: Icons.directions_car,
        iconBg: const Color(0xFFE3F2FD),
        iconColor: const Color(0xFF2196F3),
        name: 'Transportation',
        transactions: 8,
        amount: 890,
        percentage: 24,
      ),
      CategoryData(
        icon: Icons.movie,
        iconBg: const Color(0xFFF3E5F5),
        iconColor: const Color(0xFF9C27B0),
        name: 'Entertainment',
        transactions: 6,
        amount: 520,
        percentage: 14,
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return _buildCategoryItem(categories[index]);
      },
    );
  }

  Widget _buildCategoryItem(CategoryData category) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: category.iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              category.icon,
              color: category.iconColor,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: AppTheme.ledgerTitleTextStyle,
                ),
                const SizedBox(height: 4),
                Text(
                  '${category.transactions} transactions',
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
                '₹${category.amount.toStringAsFixed(0)}',
                style: AppTheme.homePageContentAmntTextStyle,
              ),
              const SizedBox(height: 4),
              Text(
                '${category.percentage}% of total',
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

class CategoryData {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String name;
  final int transactions;
  final double amount;
  final int percentage;

  CategoryData({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.name,
    required this.transactions,
    required this.amount,
    required this.percentage,
  });
}
