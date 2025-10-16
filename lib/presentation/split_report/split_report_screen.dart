import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplitReportScreen extends StatelessWidget {
  const SplitReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGroupBalance(),
                      const SizedBox(height: 24),
                      _buildMemberBalances(),
                      const SizedBox(height: 24),
                      _buildRecentTransactions(),
                    ],
                  ),
                ),
              ),
            ),
            _buildDownloadButton(),
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
            'Report Summary',
            style:
                AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 20),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            child: Assets.icons.filterIcon.svg(),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupBalance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Group Balance',
          style: AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildBalanceCard(
                icon: Icons.credit_card,
                iconBg: const Color(0xff2D3E5E),
                amount: '₹3,457',
                label: 'Total Spend',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBalanceCard(
                icon: Icons.arrow_downward,
                iconBg: AppTheme.addExpenseBtnClr.withValues(alpha: 0.3),
                amount: '₹1440',
                label: 'You Owe',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildBalanceCard(
                icon: Icons.arrow_upward,
                iconBg: AppTheme.splitGroupColor.withValues(alpha: 0.3),
                amount: '₹312',
                label: "You're Owed",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBalanceCard({
    required IconData icon,
    required Color iconBg,
    required String amount,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.reportBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            amount,
            style:
                AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTheme.homePageTitleTextStyle.copyWith(
              fontSize: 12,
              color: AppTheme.homePageSubtitleColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMemberBalances() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Member Balances',
          style: AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 16),
        _buildMemberItem(
          name: 'Sarah Chen',
          status: 'Active Member',
          label: 'Paid',
          amount: '+₹700',
          amountColor: AppTheme.amountPosTextColor,
          image: 'https://i.pravatar.cc/150?img=47',
        ),
        const SizedBox(height: 12),
        _buildMemberItem(
          name: 'Mike',
          status: 'Active Member',
          label: 'Paid',
          amount: '-45',
          amountColor: AppTheme.amountNegTextColor,
          image: 'https://i.pravatar.cc/150?img=13',
        ),
        const SizedBox(height: 12),
        _buildMemberItem(
          name: 'Sarah Chen',
          status: 'Active Member',
          label: 'Paid',
          amount: '+₹700',
          amountColor: AppTheme.amountPosTextColor,
          image: 'https://i.pravatar.cc/150?img=47',
        ),
      ],
    );
  }

  Widget _buildMemberItem({
    required String name,
    required String status,
    required String label,
    required String amount,
    required Color amountColor,
    required String image,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.reportBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(image),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTheme.homePageContentHeaderTextStyle
                      .copyWith(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: AppTheme.homePageTitleTextStyle.copyWith(
                    fontSize: 14,
                    color: AppTheme.homePageSubtitleColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                label,
                style: AppTheme.homePageTitleTextStyle.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                amount,
                style: AppTheme.homePageContentAmntTextStyle.copyWith(
                  fontSize: 16,
                  color: amountColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Transactions',
          style: AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.reportBackgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF5A3A2A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.shopping_basket,
                  color: Color(0xFFFF9966),
                  size: 26,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Groceries',
                      style: AppTheme.homePageContentHeaderTextStyle
                          .copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Paid by Sarah - Oct 6',
                      style: AppTheme.homePageTitleTextStyle.copyWith(
                        fontSize: 14,
                        color: AppTheme.homePageSubtitleColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '₹2,500',
                style: AppTheme.homePageContentAmntTextStyle
                    .copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDownloadButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: AppButton(
        textString: 'Download Report',
        buttonType: ButtonType.filled,
        expandButton: true,
        buttonState: ButtonState.enabled,
        leadingIcon: const Icon(Icons.download, color: Colors.white, size: 22),
        onPressed: (_) {
          // Handle download action
        },
        enabledButtonFilledStyle: BoxDecoration(
          color: AppTheme.splitGroupColor,
          borderRadius: BorderRadius.circular(12),
        ),
        enabledTextStyle: AppTheme.loginText.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      ),
    );
  }
}
