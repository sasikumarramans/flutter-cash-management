import 'package:bearnshare/app/helpers/app_utils.dart';
import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddExpenseMembersSheet extends StatefulWidget {
  const AddExpenseMembersSheet({super.key});

  @override
  State<AddExpenseMembersSheet> createState() => _AddExpenseMembersSheetState();

  static void showAddExpenseMembersDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddExpenseMembersSheet(),
    );
  }
}

class _AddExpenseMembersSheetState extends State<AddExpenseMembersSheet> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> selectedFriends = {};

  final List<Map<String, String>> groups = [
    {
      'name': 'Creative Team',
      'image':
          'https://images.unsplash.com/photo-1522071820081-009f0129c71c?w=100&h=100&fit=crop'
    },
    {
      'name': 'Trip Split',
      'image':
          'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=100&h=100&fit=crop'
    },
    {
      'name': 'New Year 2025',
      'image':
          'https://images.unsplash.com/photo-1482517967863-00e15c9b44be?w=100&h=100&fit=crop'
    },
  ];

  final List<Map<String, String>> friends = [
    {'name': 'Cody Fisher', 'image': 'https://i.pravatar.cc/150?img=33'},
    {'name': 'Jacob Jones', 'image': 'https://i.pravatar.cc/150?img=13'},
    {'name': 'Jane Cooper', 'image': 'https://i.pravatar.cc/150?img=47'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: AppTheme.homePageCardBgColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          _buildSearchBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGroupsSection(),
                  _buildFriendsSection(),
                ],
              ),
            ),
          ),
          _buildSubmitButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Text(
            'Add Expense',
            style:
                AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 20),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: AppTextField(
        controller: _searchController,
        hint: 'Enter name or emailId',
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
    );
  }

  Widget _buildGroupsSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Groups',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ...groups.map((group) => _buildGroupItem(group)),
        ],
      ),
    );
  }

  Widget _buildGroupItem(Map<String, String> group) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(group['image']!),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  group['name']!,
                  style: AppTheme.homePageContentHeaderTextStyle
                      .copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: AppTheme.splitBorderLineColor,
            thickness: 0.2,
          )
        ],
      ),
    );
  }

  Widget _buildFriendsSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Friends',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 8),
          ...friends.map((friend) => _buildFriendItem(friend)),
        ],
      ),
    );
  }

  Widget _buildFriendItem(Map<String, String> friend) {
    final isSelected = selectedFriends.contains(friend['name']);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedFriends.remove(friend['name']);
          } else {
            selectedFriends.add(friend['name']!);
          }
        });
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 0),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(friend['image']!),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    friend['name']!,
                    style: AppTheme.homePageContentHeaderTextStyle
                        .copyWith(fontSize: 16),
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.splitGroupColor
                          : AppTheme.splitBorderLineColor,
                      width: 2,
                    ),
                    color: isSelected
                        ? AppTheme.splitGroupColor
                        : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          const Divider(
            color: AppTheme.splitBorderLineColor,
            thickness: 0.2,
          )
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom +
        MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 0,
        bottom: bottomPadding > 0 ? bottomPadding : 20,
      ),
      child: AppButton(
        textString: 'Submit',
        buttonType: ButtonType.filled,
        expandButton: true,
        buttonState: ButtonState.enabled,
        onPressed: (_) {
          AppUtils.hideKeyboard();
          context.pop();
          context.pushNamed(MainRouter.addExpenseRoute);
        },
        enabledButtonFilledStyle: BoxDecoration(
          color: AppTheme.splitGroupColor,
          borderRadius: BorderRadius.circular(30),
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
