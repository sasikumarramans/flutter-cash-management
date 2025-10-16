import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/l10n.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isUserNameValid = false;
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool get _isFormValid => _isUserNameValid && _isEmailValid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom -
                    40,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 40),
                    _buildProfileAvatar(),
                    const SizedBox(height: 40),
                    _buildUserNameField(),
                    const SizedBox(height: 24),
                    _buildEmailField(),
                    const Spacer(),
                    _buildContinueButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              S.of(context).set_up_your_profile,
              style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          S().set_up_your_profile_hint,
          style: AppTheme.promptTextStyle
              .copyWith(fontSize: 13, color: AppTheme.genderInfoTextColor),
        ),
      ],
    );
  }

  Widget _buildProfileAvatar() {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: AppTheme.homePageCardBgColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              size: 60,
              color: Colors.white38,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                // Handle image picker
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.amountPosTextColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF1A1A1A),
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: S().user_name,
            style: AppTheme.ledgerSearchTextStyle
                .copyWith(fontSize: 15, color: Colors.white),
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
          controller: _userNameController,
          textFieldStyle: TextFieldStyle.filled,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.name,
          hint: S().usename_hint,
          prefixIcon: const Icon(
            Icons.person_outline,
            color: Colors.white60,
            size: 22,
          ),
          onValidation: (isValid) {
            setState(() {
              _isUserNameValid = isValid;
            });
          },
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: S().email_address,
            style: AppTheme.ledgerSearchTextStyle
                .copyWith(fontSize: 15, color: Colors.white),
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
          controller: _emailController,
          textFieldStyle: TextFieldStyle.filled,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.email,
          hint: S().email_hint,
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: Colors.white60,
            size: 22,
          ),
          onValidation: (isValid) {
            setState(() {
              _isEmailValid = isValid;
            });
          },
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return AppButton(
      textString: S().s_continue,
      buttonType: ButtonType.filled,
      expandButton: true,
      enabledButtonFilledStyle: BoxDecoration(
        color: const Color(0xFF2E7D32),
        borderRadius: BorderRadius.circular(30),
      ),
      enabledTextStyle: AppTheme.loginText.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      buttonState: _isFormValid ? ButtonState.enabled : ButtonState.disabled,
      onPressed: (_) {
        context.go(MainRouter.mainScreenRoute);
      },
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    );
  }
}
