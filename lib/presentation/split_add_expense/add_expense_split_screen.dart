import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddExpenseSplitScreen extends StatefulWidget {
  const AddExpenseSplitScreen({super.key});

  @override
  State<AddExpenseSplitScreen> createState() => _AddExpenseSplitScreenState();
}

class _AddExpenseSplitScreenState extends State<AddExpenseSplitScreen> {
  int selectedSplitMode = 3; // 0: equal, 1: exact, 2: shares, 3: percentage

  final List<Map<String, dynamic>> members = [
    {
      'name': 'Jerome Bell',
      'image': 'https://i.pravatar.cc/150?img=33',
      'percentage': 0.00,
      'selected': true,
      'controller': TextEditingController(text: '0.00'),
    },
    {
      'name': 'Bessie Cooper',
      'image': 'https://i.pravatar.cc/150?img=47',
      'percentage': 0.00,
      'selected': true,
      'controller': TextEditingController(text: '0.00'),
    },
    {
      'name': 'Jacob Jones',
      'image': 'https://i.pravatar.cc/150?img=13',
      'percentage': 0.00,
      'selected': true,
      'controller': TextEditingController(text: '0.00'),
    },
    {
      'name': 'Devon Lane',
      'image': 'https://i.pravatar.cc/150?img=29',
      'percentage': 0.00,
      'selected': true,
      'controller': TextEditingController(text: '0.00'),
    },
  ];

  @override
  void dispose() {
    for (var member in members) {
      member['controller']?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildAmountSection(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildSplitModeButtons(),
                    _buildMembersList(),
                  ],
                ),
              ),
            ),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
            'Add Expense',
            style:
                AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: const BoxDecoration(
        color: Color(0xFF28272D),
      ),
      child: Column(
        children: [
          Text(
            'Enter amount to split',
            style: AppTheme.homePageTitleTextStyle.copyWith(
              fontSize: 15,
              color: AppTheme.homePageSubtitleColor,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Text(
                      '₹',
                      style: AppTheme.homePageContentHeaderTextStyle.copyWith(
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(width: 0),
                    const Icon(Icons.arrow_drop_down,
                        color: Colors.white, size: 28),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '0',
                style: AppTheme.homePageContentHeaderTextStyle.copyWith(
                  fontSize: 35,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSplitModeButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildModeButton(
              Assets.icons.splitScene
                  .svg(height: 20, width: 20, fit: BoxFit.scaleDown),
              0),
          const SizedBox(width: 8),
          _buildModeButton(
              Assets.icons.split123
                  .svg(height: 20, width: 20, fit: BoxFit.scaleDown),
              1),
          const SizedBox(width: 8),
          _buildModeButton(
              Assets.icons.splitChart
                  .svg(height: 20, width: 20, fit: BoxFit.scaleDown),
              2),
          const SizedBox(width: 8),
          _buildModeButton(
              Assets.icons.splitPercentage
                  .svg(height: 20, width: 20, fit: BoxFit.scaleDown),
              3),
        ],
      ),
    );
  }

  Widget _buildModeButton(Widget icon, int index) {
    final isSelected = selectedSplitMode == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedSplitMode = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.splitGroupColor
                : AppTheme.homePageCardBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: icon,
        ),
      ),
    );
  }

  Widget _buildMembersList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Split by percentages',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 16),
          ...members.map((member) => _buildMemberItem(member)),
        ],
      ),
    );
  }

  Widget _buildMemberItem(Map<String, dynamic> member) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                member['selected'] = !member['selected'];
              });
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: member['selected']
                    ? AppTheme.splitGroupColor
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: member['selected']
                      ? AppTheme.splitGroupColor
                      : AppTheme.splitBorderLineColor,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 10,
              ),
            ),
          ),
          const SizedBox(width: 16),
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(member['image']),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              member['name'],
              style: AppTheme.homePageContentHeaderTextStyle
                  .copyWith(fontSize: 16),
            ),
          ),
          SizedBox(
            width: 100,
            child: AppTextField(
              controller: member['controller'],
              textFieldStyle: TextFieldStyle.underlined,
              textFieldState: TextFieldState.enabled,
              textFieldType: TextFieldType.text,
              textAlign: TextAlign.right,
              padding: const EdgeInsets.symmetric(vertical: 8),
              textStyle: AppTheme.historyTextStyle.copyWith(fontSize: 16),
              underlinedEnabledStyle: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white30),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.splitGroupColor),
                ),
                contentPadding: EdgeInsets.zero,
                suffixText: '%',
                suffixStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  member['percentage'] = double.tryParse(value) ?? 0.00;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          AppButton(
            textString: 'Save',
            buttonType: ButtonType.filled,
            expandButton: true,
            buttonState: ButtonState.enabled,
            onPressed: (_) {
              // Handle save action
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
        ],
      ),
    );
  }
}
