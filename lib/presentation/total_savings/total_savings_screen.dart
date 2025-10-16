import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TotalSavingsScreen extends StatefulWidget {
  const TotalSavingsScreen({super.key});

  @override
  State<TotalSavingsScreen> createState() => _TotalSavingsScreenState();
}

class _TotalSavingsScreenState extends State<TotalSavingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSavingsBanner(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildStatsCards(),
                  const SizedBox(height: 16),
                  _buildRecentEntriesHeader(),
                ],
              ),
            ),
            Expanded(
              child: _buildRecentEntries(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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

  Widget _buildSavingsBanner() {
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
                    'Jun 25, 2025',
                    style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '₹15,750',
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
                '+₹3,200 this month |',
                style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
              ),
              const SizedBox(width: 12),
              Text(
                '85% of goal',
                style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
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
                  '+₹3,200',
                  style: AppTheme.homePageContentAmntTextStyle
                      .copyWith(fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(
                  '+12.5%',
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
                  '85%',
                  style: AppTheme.homePageContentAmntTextStyle
                      .copyWith(fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹2,750 to go',
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
        ),
        Row(
          children: [
            Assets.icons.filterIcon.svg(),
            const SizedBox(width: 6),
            Text(
              'Filters',
              style: AppTheme.ledgerSearchTextStyle
                  .copyWith(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentEntries() {
    final entries = [
      SavingsEntry(
        icon: Icons.add,
        iconBg: const Color(0xFFE8F5E9),
        iconColor: const Color(0xFF4CAF50),
        title: 'Salary Deposit',
        date: 'Dec 25, 2024',
        amount: '+₹2,500',
        amountColor: AppTheme.tertiaryColor,
        tag: 'Savings',
      ),
      SavingsEntry(
        icon: Icons.add,
        iconBg: const Color(0xFFE8F5E9),
        iconColor: AppTheme.tertiaryColor,
        title: 'Bonus Savings',
        date: 'Dec 25, 2024',
        amount: '+₹700',
        amountColor: AppTheme.tertiaryColor,
        tag: 'Bonus',
      ),
      SavingsEntry(
        icon: Icons.remove,
        iconBg: const Color(0xFFFFEBEE),
        iconColor: const Color(0xFFFF5252),
        title: 'Emergency With...',
        date: 'Dec 18, 2024',
        amount: '-₹500',
        amountColor: AppTheme.addExpenseBtnClr,
        tag: 'Emergency',
      ),
      SavingsEntry(
        icon: Icons.add,
        iconBg: const Color(0xFFE8F5E9),
        iconColor: const Color(0xFF4CAF50),
        title: 'Monthly Savings',
        date: 'Dec 10, 2024',
        amount: '+₹1,000',
        amountColor: AppTheme.tertiaryColor,
        tag: 'Savings',
      ),
      SavingsEntry(
        icon: Icons.add,
        iconBg: const Color(0xFFE8F5E9),
        iconColor: AppTheme.tertiaryColor,
        title: 'Investment Return',
        date: 'Dec 5, 2024',
        amount: '+₹1,500',
        amountColor: AppTheme.tertiaryColor,
        tag: 'Investment',
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: entries.length + 1,
      itemBuilder: (context, index) {
        if (index == entries.length) {
          return Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 16),
            child: _buildViewAllButton(),
          );
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildEntryItem(
            icon: entries[index].icon,
            iconBg: entries[index].iconBg,
            iconColor: entries[index].iconColor,
            title: entries[index].title,
            date: entries[index].date,
            amount: entries[index].amount,
            amountColor: entries[index].amountColor,
            tag: entries[index].tag,
          ),
        );
      },
    );
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
        onPressed: () {},
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

class SavingsEntry {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String date;
  final String amount;
  final Color amountColor;
  final String tag;

  SavingsEntry({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.date,
    required this.amount,
    required this.amountColor,
    required this.tag,
  });
}
