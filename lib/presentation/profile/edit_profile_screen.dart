import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/data/local/hive_manager.dart';
import 'package:bearnshare/generated/l10n.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/app_text_field.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  bool _isUserNameValid = false;
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    context.pop();
    return true;
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _companyNameController.dispose();
    BackButtonInterceptor.remove(myInterceptor);
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
                    const SizedBox(height: 20),
                    _buildProfileAvatar(),
                    const SizedBox(height: 20),
                    _buildUserNameField(),
                    const SizedBox(height: 15),
                    _buildEmailField(),
                    const SizedBox(height: 15),
                    _buildCompanyNameField(),
                    const SizedBox(height: 15),
                    _buildAddressField(),
                    const SizedBox(height: 40),
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
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(5),
                child:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 22),
              ),
              onTap: () {
                context.pop();
              },
            ),
            const SizedBox(width: 15),
            Text(
              "Edit profile",
              style: AppTheme.ledgerTitleTextStyle.copyWith(fontSize: 18),
            ),
          ],
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
                  color: AppTheme.splitGroupColor,
                  shape: BoxShape.circle,
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
            text: "Full Name",
            style: AppTheme.ledgerSearchTextStyle
                .copyWith(fontSize: 15, color: Colors.white),
            children: const [
              TextSpan(
                text: '',
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

  Widget _buildCompanyNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "Company/Organization",
            style: AppTheme.ledgerSearchTextStyle
                .copyWith(fontSize: 15, color: Colors.white),
            children: const [
              TextSpan(
                text: '',
                style: TextStyle(
                  color: Color(0xFFFF5252),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _companyNameController,
          textFieldStyle: TextFieldStyle.filled,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.name,
          hint: "Enter company/organization",
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

  Widget _buildAddressField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: "Address",
            style: AppTheme.ledgerSearchTextStyle
                .copyWith(fontSize: 15, color: Colors.white),
            children: const [
              TextSpan(
                text: '',
                style: TextStyle(
                  color: Color(0xFFFF5252),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        AppTextField(
          controller: _addressController,
          textFieldStyle: TextFieldStyle.filled,
          textFieldState: TextFieldState.enabled,
          textFieldType: TextFieldType.name,
          hint: "Enter address",
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
        GetIt.I<HiveManager>().saveToHive(HiveManager.profileUpdatedKey, true);
        context.go(MainRouter.mainScreenRoute);
      },
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
    );
  }
}
