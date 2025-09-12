import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:ev_flutter_app/app/helpers/app_utils.dart';
import 'package:ev_flutter_app/app/helpers/extensions/string_extensions.dart';
import 'package:ev_flutter_app/app/router/router_manager.dart';
import 'package:ev_flutter_app/app/theme/app_theme.dart';
import 'package:ev_flutter_app/generated/l10n.dart';
import 'package:ev_flutter_app/presentation/auth/login/bloc/login_bloc.dart';
import 'package:ev_flutter_app/presentation/auth/login/bloc/login_event.dart';
import 'package:ev_flutter_app/presentation/auth/login/bloc/login_state.dart';
import 'package:ev_flutter_app/presentation/auth/login_router.dart';
import 'package:ev_flutter_app/presentation/component/app_button.dart';
import 'package:ev_flutter_app/presentation/component/app_text_field.dart';
import 'package:ev_flutter_app/presentation/main_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isContinue = false;
  late TextEditingController emailTextEditingController;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    emailTextEditingController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Stack(
              children: [
                Container(
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Weave together worlds and ideas",
                        textAlign: TextAlign.left,
                        style: AppTheme.loginSignInOrCreateAnAccountText
                            .copyWith(fontSize: 20),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        S.of(context).s_login_hint,
                        textAlign: TextAlign.left,
                        style: AppTheme.loginSignInOrCreateAnAccountText
                            .copyWith(
                                color: AppTheme.loginHintTextColor,
                                fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 32),
                    AppTextField(
                      textFieldStyle: TextFieldStyle.filled,
                      textFieldState: TextFieldState.enabled,
                      textFieldType: TextFieldType.email,
                      controller: emailTextEditingController,
                      hint: S.of(context).email_hint,
                      onChanged: (value) {
                        context.read<LoginBloc>().add(EmailIdChanged(value));
                      },
                      onValidation: (isValid) {
                        if (isValid) {
                          context.read<LoginBloc>().add(EmailIdCompleted(
                                isValidEmailId: isValid,
                              ));
                        } else {
                          context.read<LoginBloc>().add(EmailIdCompleted(
                                isValidEmailId: isValid,
                              ));
                        }
                      },
                      textStyle: AppTheme.loginEmailValue,
                      onTouchOutside: (event) {
                        QuiltUtils.hideKeyboard();
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocConsumer<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return AppButton(
                          buttonType: ButtonType.filled,
                          textString: S.of(context).continue_with_email,
                          onPressed: (value) {
                            QuiltUtils.hideKeyboard();
                            if (state.isValidEmailId) {
                              context
                                  .read<LoginBloc>()
                                  .add(const LoginWithEmailRequested(
                                    resendRequest: false,
                                  ));
                            }
                          },
                          buttonState: state.isValidEmailId
                              ? ButtonState.completed
                              : ButtonState.enabled,
                          completedButtonFilledStyle:
                              AppTheme.buttonCompletedFilledFabric,
                          enabledButtonFilledStyle:
                              AppTheme.buttonEnabledFilled.copyWith(
                            color: Colors.black,
                          ),
                          enabledTextStyle: AppTheme.textEnabledTheme.copyWith(
                            color: AppTheme.buttonDisabledColor,
                          ),
                          completedTextStyle:
                              AppTheme.textEnabledTheme.copyWith(
                            color: Colors.white,
                          ),
                          expandButton: true,
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
                            context.go(MainRouter.mainScreenRoute);
                            break;
                          default:
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
    super.dispose();
  }
}
