import 'package:ev_flutter_app/app/theme/app_theme.dart';
import 'package:ev_flutter_app/generated/assets.gen.dart';
import 'package:ev_flutter_app/generated/l10n.dart';
import 'package:ev_flutter_app/presentation/component/app_button.dart';
import 'package:flutter/material.dart';

class LedgerBookScreen extends StatelessWidget {
  const LedgerBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildSearchBar(),
            _buildSummaryCards(),
            Expanded(
              child: _buildTransactionsList(),
            ),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Text(
            'Home Expenses',
            style: AppTheme.ledgerTitleTextStyle,
          ),
          const SizedBox(width: 8),
          const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 24),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.reportBtnColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Assets.icons.reportImg.svg(),
                const SizedBox(width: 6),
                Text(
                  S().s_report,
                  style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.homePageCardBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search,
                      color: AppTheme.searchTextColor, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    'Search transactions',
                    style: AppTheme.ledgerSearchTextStyle
                        .copyWith(color: AppTheme.searchTextColor),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.homePageCardBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Assets.icons.filterIcon.svg(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.homePageCardBgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildSummaryItem(S().total_entries, '257', Colors.white),
            ),
            Container(
              width: 1,
              height: 40,
              color: AppTheme.splitBorderLineColor,
            ),
            Expanded(
              child: _buildSummaryItem(
                  S().total_cash_in, '\$ 43,000', AppTheme.amountPosTextColor),
            ),
            Container(
              width: 1,
              height: 40,
              color: AppTheme.splitBorderLineColor,
            ),
            Expanded(
              child: _buildSummaryItem(
                  S().total_cash_out, '\$ 58,000', AppTheme.addExpenseBtnClr),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(
          label,
          style: AppTheme.homePageTitleTextStyle.copyWith(fontSize: 12),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: AppTheme.homePageContentHeaderTextStyle
              .copyWith(fontSize: 16, color: valueColor),
        ),
      ],
    );
  }

  Widget _buildTransactionsList() {
    final transactions = [
      Transaction('Grocery Shopping', 'Today, 2:30 PM', 2500, true),
      Transaction('Freelance Payment', 'Today, 2:30 PM', 500, true),
      Transaction('Electricity Bill', 'Dec 15, 10:20 AM', 500, false),
      Transaction('Salary Deposit', 'Dec 15, 10:20 AM', 40000, true),
      Transaction('Gas Station', 'Dec 15, 10:20 AM', 4500, false),
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return _buildTransactionCard(transactions[index]);
      },
    );
  }

  Widget _buildTransactionCard(Transaction transaction) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
                Text(
                  transaction.title,
                  style: AppTheme.homePageContentHeaderTextStyle
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(height: 6),
                Text(
                  transaction.date,
                  style: AppTheme.homePageTitleTextStyle
                      .copyWith(color: AppTheme.genderInfoTextColor),
                ),
              ],
            ),
          ),
          Text(
            '${transaction.isIncome ? '+' : '-'}₹${transaction.amount.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: transaction.isIncome
                  ? AppTheme.amountPosTextColor
                  : AppTheme.addExpenseBtnClr,
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {},
            child: Assets.icons.editIcon.svg(),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {},
            child: Assets.icons.deleteIcon.svg(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
                buttonType: ButtonType.filled,
                textString: S().add_income,
                leadingIcon: const Icon(
                  Icons.add,
                  size: 20,
                  color: Colors.white,
                ),
                onPressed: (value) {},
                buttonState: ButtonState.enabled,
                expandButton: true,
                enabledButtonFilledStyle: BoxDecoration(
                  color: AppTheme.amountPosTextColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledTextStyle: AppTheme.loginText.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                )),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(
                buttonType: ButtonType.filled,
                textString: S().add_expense,
                leadingIcon: const Icon(
                  Icons.add,
                  size: 20,
                  color: Colors.white,
                ),
                onPressed: (value) {},
                buttonState: ButtonState.enabled,
                expandButton: true,
                enabledButtonFilledStyle: BoxDecoration(
                  color: AppTheme.addExpenseBtnClr,
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledTextStyle: AppTheme.loginText.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}

class Transaction {
  final String title;
  final String date;
  final double amount;
  final bool isIncome;

  Transaction(this.title, this.date, this.amount, this.isIncome);
}
