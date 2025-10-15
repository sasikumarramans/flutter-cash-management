import 'package:ev_flutter_app/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(
              child: _buildHistoryList(),
            ),
          ],
        ),
      ),
    );
  }

  // Sample data structure - replace with your actual data source
  List<HistorySection> _getHistorySections() {
    return [
      HistorySection(
        date: 'Today',
        totalAmount: 1245.00,
        isPositive: true,
        transactions: [
          TransactionItem(
            icon: Icons.arrow_downward,
            iconBg: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF4CAF50),
            title: 'Salary Deposit',
            time: '2:30 PM',
            amount: 2500.00,
            isIncome: true,
          ),
          TransactionItem(
            icon: Icons.shopping_cart,
            iconBg: const Color(0xFFFFEBEE),
            iconColor: const Color(0xFFFF5252),
            title: 'Grocery Store',
            time: '2:30 PM',
            amount: 856.00,
            isIncome: false,
          ),
          TransactionItem(
            icon: Icons.access_time,
            iconBg: const Color(0xFFFFF3E0),
            iconColor: const Color(0xFFFF9800),
            title: 'Rent Payment',
            time: '2:30 PM',
            amount: 2500.00,
            isIncome: false,
          ),
          TransactionItem(
            icon: Icons.arrow_downward,
            iconBg: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF4CAF50),
            title: 'Salary Deposit',
            time: '2:30 PM',
            amount: 2500.00,
            isIncome: true,
          ),
          TransactionItem(
            icon: Icons.access_time,
            iconBg: const Color(0xFFFFF3E0),
            iconColor: const Color(0xFFFF9800),
            title: 'Rent Payment',
            time: '2:30 PM',
            amount: 2500.00,
            isIncome: false,
          ),
        ],
      ),
      HistorySection(
        date: 'Yesterday',
        totalAmount: 1245.00,
        isPositive: true,
        transactions: [
          TransactionItem(
            icon: Icons.shopping_cart,
            iconBg: const Color(0xFFFFEBEE),
            iconColor: const Color(0xFFFF5252),
            title: 'Grocery Store',
            time: '2:30 PM',
            amount: 856.00,
            isIncome: false,
          ),
          TransactionItem(
            icon: Icons.arrow_downward,
            iconBg: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF4CAF50),
            title: 'Salary Deposit',
            time: '2:30 PM',
            amount: 2500.00,
            isIncome: true,
          ),
        ],
      ),
    ];
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 20),
          Text(
            'History',
            style: AppTheme.ledgerTitleTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.homePageCardBgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppTheme.searchTextColor, size: 22),
            const SizedBox(width: 12),
            Text(
              'Search by name, amount...',
              style: AppTheme.ledgerSearchTextStyle
                  .copyWith(color: AppTheme.searchTextColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList() {
    final sections = _getHistorySections();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: sections.length,
      itemBuilder: (context, sectionIndex) {
        final section = sections[sectionIndex];

        return Column(
          children: [
            // Date section header
            _buildDateSection(
              section.date,
              section.totalAmount,
              section.isPositive,
            ),
            // Transaction items for this section
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: section.transactions.length,
              itemBuilder: (context, transactionIndex) {
                final transaction = section.transactions[transactionIndex];
                return _buildTransactionItem(
                  icon: transaction.icon,
                  iconBg: transaction.iconBg,
                  iconColor: transaction.iconColor,
                  title: transaction.title,
                  time: transaction.time,
                  amount: transaction.amount,
                  isIncome: transaction.isIncome,
                );
              },
            ),
            if (sectionIndex < sections.length - 1) const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  Widget _buildDateSection(String date, double amount, bool isPositive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppTheme.tabDividerColor, width: 1),
          bottom: BorderSide(color: AppTheme.tabDividerColor, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: AppTheme.historyTextStyle,
          ),
          Text(
            '${isPositive ? '+' : '-'} \$${amount.toStringAsFixed(2)}',
            style: AppTheme.historyAmntTextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String time,
    required double amount,
    required bool isIncome,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppTheme.tabDividerColor, width: 0.5),
        ),
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
            child: Icon(
              icon,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.homePageContentHeaderTextStyle
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: AppTheme.homePageTitleTextStyle
                      .copyWith(color: AppTheme.genderInfoTextColor),
                ),
              ],
            ),
          ),
          Text(
            '${isIncome ? '+' : '-'}₹${amount.toStringAsFixed(2)}',
            style: AppTheme.homePageContentHeaderTextStyle.copyWith(
                fontSize: 16,
                color: isIncome
                    ? AppTheme.amountPosTextColor
                    : AppTheme.addExpenseBtnClr),
          ),
        ],
      ),
    );
  }
}

// Data models for history sections and transactions
class HistorySection {
  final String date;
  final double totalAmount;
  final bool isPositive;
  final List<TransactionItem> transactions;

  HistorySection({
    required this.date,
    required this.totalAmount,
    required this.isPositive,
    required this.transactions,
  });
}

class TransactionItem {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String time;
  final double amount;
  final bool isIncome;

  TransactionItem({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.time,
    required this.amount,
    required this.isIncome,
  });
}
