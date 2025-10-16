import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplitFriendsScreen extends StatefulWidget {
  const SplitFriendsScreen({super.key});

  @override
  State<SplitFriendsScreen> createState() => _SplitFriendsScreenState();
}

class _SplitFriendsScreenState extends State<SplitFriendsScreen> {
  int selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();

  // Sample group data
  final List<Map<String, dynamic>> _groups = [
    {
      'icon': Icons.group,
      'iconBg': const Color(0xFFE3F2FD),
      'iconColor': const Color(0xFF2196F3),
      'title': 'Weekend Trip',
      'time': '2 Hours ago',
      'amount': '+₹700',
      'amountColor': const Color(0xFF4CAF50),
      'label': 'You owe',
    },
    {
      'icon': Icons.home,
      'iconBg': const Color(0xFFF3E5F5),
      'iconColor': const Color(0xFF9C27B0),
      'title': 'Apartment',
      'time': '1 day ago',
      'amount': '₹2,500',
      'amountColor': const Color(0xFF4CAF50),
      'label': "You're owed",
    },
    {
      'icon': Icons.attach_money,
      'iconBg': const Color(0xFFE3F2FD),
      'iconColor': const Color(0xFF2196F3),
      'title': 'Split',
      'time': '1 day ago',
      'amount': '₹2,500',
      'amountColor': const Color(0xFFFF5252),
      'label': 'You owe',
    },
    {
      'icon': Icons.apartment,
      'iconBg': const Color(0xFFF3E5F5),
      'iconColor': const Color(0xFF9C27B0),
      'title': 'Rent',
      'time': '1 day ago',
      'amount': '₹1,750',
      'amountColor': const Color(0xFF4CAF50),
      'label': "You're owed",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildFilterTabs(),
            Expanded(
              child: _buildGroupsList(),
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
            context.pushNamed(MainRouter.addExpenseRoute);
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton('All Group', 0),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildTabButton('Active', 1),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildTabButton('Settled', 2),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
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
        setState(() {
          selectedTab = index;
        });
      },
    );
  }

  Widget _buildGroupsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: _groups.length + 1, // +1 for the header
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Your Friends',
              style: AppTheme.ledgerTitleTextStyle,
            ),
          );
        }

        final groupIndex = index - 1;
        final group = _groups[groupIndex];

        return Padding(
          padding: EdgeInsets.only(
            bottom: groupIndex == _groups.length - 1 ? 100 : 12,
          ),
          child: _buildGroupItem(
            icon: group['icon'] as IconData,
            iconBg: group['iconBg'] as Color,
            iconColor: group['iconColor'] as Color,
            title: group['title'] as String,
            time: group['time'] as String,
            amount: group['amount'] as String,
            amountColor: group['amountColor'] as Color,
            label: group['label'] as String,
          ),
        );
      },
    );
  }

  Widget _buildGroupItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String time,
    required String amount,
    required Color amountColor,
    required String label,
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
            padding: const EdgeInsets.all(14),
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
                  title,
                  style: AppTheme.ledgerTitleTextStyle,
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: AppTheme.ledgerSearchTextStyle,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                label,
                style: AppTheme.ledgerSearchTextStyle
                    .copyWith(color: Colors.white),
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
}
