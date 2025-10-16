import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _memberSearchController = TextEditingController();
  int? selectedIconIndex;

  final List<IconData> defaultIcons = [
    Icons.flight,
    Icons.home,
    Icons.group,
    Icons.coffee,
    Icons.restaurant,
    Icons.credit_card,
    Icons.favorite,
    Icons.directions_car,
  ];

  @override
  void dispose() {
    _bookNameController.dispose();
    _memberSearchController.dispose();
    super.dispose();
  }

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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBookNameField(),
                    const SizedBox(height: 16),
                    _buildDefaultIcons(),
                  ],
                ),
              ),
            ),
            _buildCreateButton(),
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
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Text(
            'Add Book',
            style:
                AppTheme.homePageContentHeaderTextStyle.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildBookNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Book Name',
          style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _bookNameController,
          textFieldStyle: TextFieldStyle.outlined,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.text,
          textStyle: AppTheme.historyTextStyle.copyWith(fontSize: 15),
          outlinedEnabledStyle: InputDecoration(
            hintText: 'Enter a Book Name',
            hintStyle: AppTheme.homePageTitleTextStyle.copyWith(
              fontSize: 15,
              color: AppTheme.homePageSubtitleColor,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.splitBorderLineColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.splitBorderLineColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.splitGroupColor),
            ),
            filled: true,
            fillColor: AppTheme.primaryColor,
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultIcons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Default icons',
          style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            ...List.generate(
              defaultIcons.length,
              (index) => _buildIconButton(defaultIcons[index], index),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, int index) {
    final isSelected = selectedIconIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIconIndex = index;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.splitGroupColor : AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppTheme.splitGroupColor
                : AppTheme.splitBorderLineColor,
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildAddNewButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.splitBorderLineColor,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.add_circle_outline,
              color: Colors.white,
              size: 22,
            ),
            const SizedBox(width: 6),
            Text(
              'Add new',
              style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMembers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Members',
          style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _memberSearchController,
          textFieldStyle: TextFieldStyle.outlined,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.text,
          textStyle: AppTheme.historyTextStyle.copyWith(fontSize: 15),
          outlinedEnabledStyle: InputDecoration(
            hintText: 'Enter name, email, or phone',
            hintStyle: AppTheme.homePageTitleTextStyle.copyWith(
              fontSize: 15,
              color: AppTheme.homePageSubtitleColor,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 22,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.splitBorderLineColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: AppTheme.splitBorderLineColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.splitGroupColor),
            ),
            filled: true,
            fillColor: AppTheme.primaryColor,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: AppButton(
        textString: 'Create Book',
        buttonType: ButtonType.filled,
        expandButton: true,
        buttonState: ButtonState.enabled,
        onPressed: (_) {
          // Handle create book action
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
