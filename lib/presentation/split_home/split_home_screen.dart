import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_bloc.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_state.dart';
import 'package:bearnshare/presentation/dashboard/dash_board_router.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplitHomeScreen extends StatefulWidget {
  const SplitHomeScreen({super.key});

  @override
  State<SplitHomeScreen> createState() => _SplitHomeScreenState();
}

class _SplitHomeScreenState extends State<SplitHomeScreen> {
  bool isGroupSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(13),
          margin: const EdgeInsets.only(bottom: 80),
          width: 140,
          decoration: BoxDecoration(
              color: AppTheme.homePageCardBgColor,
              borderRadius: BorderRadius.circular(35),
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [AppTheme.amountPosTextColor, Color(0xff007652)])),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.splitWiseIcon.svg(),
              const SizedBox(
                width: 10,
              ),
              Text(
                "LedgerBook",
                style: AppTheme.homePageTitleTextStyle,
              )
            ],
          ),
        ),
        onTap: () {
          context.go(DashboardRouter.homeRoute);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              _buildOverallSpending(),
              _buildActionButtons(),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: AppTheme.splitBorderLineColor,
                endIndent: 15,
                indent: 15,
              ),
              _buildSummarySection(),
              _buildTransactionsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text.rich(
              TextSpan(
                text: 'Welcome, ',
                style: AppTheme.homePageContentHeaderTextStyle
                    .copyWith(fontSize: 18),
                children: [
                  TextSpan(
                    text: state.userDataObject?.username ?? "" "!",
                    style: AppTheme.homePageContentHeaderTextStyle.copyWith(
                        fontSize: 18, color: AppTheme.amountPosTextColor),
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Assets.icons.graph.svg(),
              ),
              onTap: () {
                context.pushNamed(MainRouter.splitReportSummaryRoute);
              },
            ),
            const SizedBox(width: 8),
            Assets.icons.search.svg(),
          ],
        ),
      );
    });
  }

  Widget _buildOverallSpending() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          Text(
            '₹8,400',
            style: AppTheme.homePageContentAmntTextStyle.copyWith(fontSize: 30),
          ),
          Text(
            'Overall Spending',
            style: AppTheme.ledgerSearchTextStyle.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              icon: Assets.icons.group.svg(color: Colors.white),
              label: 'Create Group',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              icon: Assets.icons.addExpense.svg(color: Colors.white),
              label: 'Add Expenses',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              icon: Assets.icons.friends.svg(color: Colors.white),
              label: 'Add Member',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({required Widget icon, required String label}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 40),
          decoration: BoxDecoration(
              color: AppTheme.homePageCardBgColor,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: const Color(0xff45444C))),
          child: icon,
        ),
        const SizedBox(height: 8),
        Text(label,
            style: AppTheme.promptTextStyle
                .copyWith(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary',
            style: AppTheme.ledgerTitleTextStyle,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.homePageCardBgColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF6B35),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'You get',
                        style: AppTheme.ledgerSearchTextStyle
                            .copyWith(color: Colors.white, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹3,200',
                        style: AppTheme.homePageContentAmntTextStyle
                            .copyWith(fontSize: 18),
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
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFF7B68EE),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'You give',
                        style: AppTheme.ledgerSearchTextStyle
                            .copyWith(color: Colors.white, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹5,200',
                        style: AppTheme.homePageContentAmntTextStyle
                            .copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.homePageCardBgColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            _buildFilterTabs(),
            _buildTransactionItem(
              title: 'Weekend Trip',
              time: '2 Hours ago',
              amount: '₹2,500',
              amountLabel: 'You owe',
              amountColor: Colors.white,
            ),
            _buildDivider(),
            _buildTransactionItem(
              title: 'House Rent',
              time: '2 Hours ago',
              amount: '₹2,500',
              amountLabel: 'You are owed',
              amountColor: const Color(0xFFFF6B6B),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isGroupSelected = true;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isGroupSelected
                    ? AppTheme.splitGroupColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Group',
                style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                isGroupSelected = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color:
                    !isGroupSelected ? AppTheme.splitGroupColor : Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Individual',
                style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 12),
              ),
            ),
          ),
          const Spacer(),
          Text(
            'View all',
            style: AppTheme.historyTextStyle.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required String title,
    required String time,
    required String amount,
    required String amountLabel,
    required Color amountColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: const BoxDecoration(
              color: AppTheme.splitGroupColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.group,
              color: Colors.white,
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
                  style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: AppTheme.historyTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amountLabel,
                style: AppTheme.historyTextStyle.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                amount,
                style: AppTheme.homePageContentAmntTextStyle
                    .copyWith(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 1,
        color: AppTheme.splitBorderLineColor,
      ),
    );
  }
}
