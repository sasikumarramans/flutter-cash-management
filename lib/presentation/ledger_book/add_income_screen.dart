import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddIncomeScreen extends StatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController(
    text: '29/09/2025, 10:06 AM',
  );
  final TextEditingController _amountController = TextEditingController(
    text: '0.00',
  );
  bool _isDescriptionValid = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    _dateController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _isDescriptionValid &&
      _amountController.text.isNotEmpty &&
      _amountController.text != '0.00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildAmountSection(),
                    _buildFormSection(),
                  ],
                ),
              ),
            ),
            _buildActionButtons(),
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
            onTap: () {
              context.pop();
            },
            child: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Text(
            'Add Income',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 20),
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
        color: AppTheme.homePageCardBgColor,
        border: Border(
          bottom: BorderSide(color: Color(0xFF3A3A4A), width: 1),
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Amount',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3A4A),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  children: [
                    Text(
                      '₹',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_drop_down, color: Colors.white, size: 24),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '0.00',
                    hintStyle: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white54,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescriptionField(),
          const SizedBox(height: 24),
          _buildDateTimeField(),
        ],
      ),
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Particulars',
            style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 15),
            children: const [
              TextSpan(
                text: '*',
                style: TextStyle(
                  color: Color(0xFFFF5252),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _descriptionController,
          textFieldStyle: TextFieldStyle.filled,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.text,
          hint: 'Enter description',
          maxLines: 3,
          onValidation: (isValid) {
            setState(() {
              _isDescriptionValid = isValid;
            });
          },
          padding: const EdgeInsets.all(16),
        ),
      ],
    );
  }

  Widget _buildDateTimeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date & Time',
          style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _dateController,
          textFieldStyle: TextFieldStyle.filled,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.text,
          readOnly: true,
          suffixIcon: const Icon(
            Icons.calendar_today,
            color: Colors.white60,
            size: 20,
          ),
          onTap: () {
            // Open date picker
          },
          padding: const EdgeInsets.all(16),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          AppButton(
            textString: 'Save',
            buttonType: ButtonType.filled,
            expandButton: true,
            buttonState:
                _isFormValid ? ButtonState.enabled : ButtonState.disabled,
            onPressed: (_) {
              // Handle save
            },
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            enabledButtonFilledStyle: BoxDecoration(
              color: AppTheme.amountPosTextColor,
              borderRadius: BorderRadius.circular(30),
            ),
            enabledTextStyle: AppTheme.loginText.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          AppButton(
            textString: 'Cancel',
            buttonType: ButtonType.filled,
            expandButton: true,
            buttonState: ButtonState.enabled,
            onPressed: (_) {
              context.pop();
            },
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            enabledButtonFilledStyle: BoxDecoration(
              color: AppTheme.amountPosTextColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            enabledTextStyle: AppTheme.loginText.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppTheme.amountPosTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
