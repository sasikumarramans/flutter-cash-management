import 'package:ev_flutter_app/app/helpers/app_utils.dart';
import 'package:ev_flutter_app/app/helpers/extensions/string_extensions.dart';
import 'package:ev_flutter_app/app/router/router_manager.dart';
import 'package:ev_flutter_app/app/theme/app_theme.dart';
import 'package:ev_flutter_app/generated/assets.gen.dart';
import 'package:ev_flutter_app/presentation/auth/login/bloc/login_bloc.dart';
import 'package:ev_flutter_app/presentation/auth/login/bloc/login_event.dart';
import 'package:ev_flutter_app/presentation/auth/login/bloc/login_state.dart';
import 'package:ev_flutter_app/presentation/auth/login_router.dart';
import 'package:ev_flutter_app/presentation/component/app_button.dart';
import 'package:ev_flutter_app/presentation/component/app_text_field.dart';
import 'package:ev_flutter_app/presentation/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isContinue = false;
  final TextEditingController _phoneController = TextEditingController();
  final String _selectedCountryCode = '+91';

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.loginBgColor,
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<LoginBloc, LoginState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Center(
                          child: Assets.images.loginBg.image(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Verify phone number',
                              textAlign: TextAlign.center,
                              style: AppTheme.loginText,
                            ),
                          ),

                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "We'll send you a code, it helps keep your\naccount secure",
                              style: AppTheme.loginText.copyWith(
                                  color: AppTheme.genderInfoTextColor,
                                  fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Phone input row
                          Row(
                            children: [
                              // Country code dropdown
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2A2A2A),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xff777474),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      '🇮🇳',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      _selectedCountryCode,
                                      style: AppTheme.loginText.copyWith(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white54,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: AppTextField(
                                  controller: _phoneController,
                                  onChanged: (value) {
                                    context
                                        .read<LoginBloc>()
                                        .add(MobileNumberChanged(value));
                                  },
                                  onValidation: (isValid) {
                                    if (isValid) {
                                      context
                                          .read<LoginBloc>()
                                          .add(MobileNumberCompleted(
                                            isValidMobileNumber: isValid,
                                          ));
                                    } else {
                                      context
                                          .read<LoginBloc>()
                                          .add(MobileNumberCompleted(
                                            isValidMobileNumber: isValid,
                                          ));
                                    }
                                  },
                                  textFieldStyle: TextFieldStyle.filled,
                                  textFieldState: TextFieldState.enabled,
                                  textFieldType: TextFieldType.mobile,
                                  hint: 'eg. 9876543210',
                                  maxLength: 10,
                                  showMaxLengthIndicator: false,
                                  textStyle: AppTheme.loginText.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).viewInsets.bottom > 0
                                      ? 20
                                      : 40),
                          AppButton(
                              buttonType: ButtonType.filled,
                              textString: 'Continue',
                              onPressed: (value) {
                                AppUtils.hideKeyboard();
                                if (state.isValidMobileNumber) {
                                  context
                                      .read<LoginBloc>()
                                      .add(const LoginWithMobileNumberRequested(
                                        resendRequest: false,
                                      ));
                                }
                              },
                              buttonState: state.isValidMobileNumber
                                  ? ButtonState.enabled
                                  : ButtonState.disabled,
                              expandButton: true,
                              enabledButtonFilledStyle: BoxDecoration(
                                color: const Color(0xFF2E7D32),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              enabledTextStyle: AppTheme.loginText.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              )),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        listenWhen: (previous, current) {
          return previous.status != current.status &&
                  current.status == LoginStatus.otpSent ||
              current.status == LoginStatus.userAuthenticated;
        },
        listener: (BuildContext context, LoginState state) {
          switch (state.status) {
            case LoginStatus.otpSent:
              if (GetIt.I<RouterManager>()
                  .currentRoute
                  .notContains(LoginRouter.otpScreenRoute)) {
                context.pushNamed(LoginRouter.otpScreenRoute);
              }
              break;
            case LoginStatus.userAuthenticated:
              print("userAuthenticated");
              context.go(MainRouter.mainScreenRoute);
              break;
            default:
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }
}
