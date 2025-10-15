import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/assets.gen.dart';
import 'package:bearnshare/presentation/auth/otp/bloc/otp_bloc.dart';
import 'package:bearnshare/presentation/auth/otp/bloc/otp_event.dart';
import 'package:bearnshare/presentation/auth/otp/bloc/otp_state.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:bearnshare/presentation/component/conditional_widget.dart';
import 'package:bearnshare/presentation/component/otp_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with WidgetsBindingObserver {
  final _otpTextController = TextEditingController();
  final _otpFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _otpFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // Top illustration section
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back button
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).pop();
                      },
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: Color(0xFFD4E7D7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                          size: 24,
                        ),
                      ),
                    ),

                    // Illustration placeholder
                    Expanded(
                      child: Center(
                        child: Assets.images.otpBg.image(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom dark section with OTP fields
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Verify OTP',
                          style: AppTheme.loginText,
                        ),
                        const SizedBox(height: 8),
                        BlocBuilder<OtpBloc, OtpState>(
                          builder: (context, state) {
                            return RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                                children: [
                                  const TextSpan(
                                    text: "We've sent a code to ",
                                  ),
                                  TextSpan(
                                    text: state.emailId.isNotEmpty
                                        ? state.emailId
                                        : '+91 XXXXXXXX',
                                    style: AppTheme.loginText
                                        .copyWith(fontSize: 15),
                                  ),
                                  const TextSpan(
                                    text: '.\nPlease enter it below.',
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        // OTP Fields
                        BlocConsumer<OtpBloc, OtpState>(
                          listenWhen: (previous, current) {
                            return previous.status != current.status &&
                                current.status == OtpStatus.otpRequested;
                          },
                          listener: (context, state) {
                            _otpTextController.clear();
                            _otpFocusNode.requestFocus();
                          },
                          builder: (context, state) {
                            return OtpFields(
                              length: 4,
                              controller: _otpTextController,
                              focusNode: _otpFocusNode,
                              isAnimateError: true,
                              isAnimateFields: false,
                              customDefaultPinTheme:
                                  AppTheme.otpDefaultPinTheme,
                              customFocusedPinTheme:
                                  AppTheme.otpFocusedPinTheme,
                              customSubmittedPinTheme:
                                  AppTheme.otpSubmittedPinTheme,
                              customErrorPinTheme: AppTheme.otpErrorPinTheme,
                              onTap: () {
                                context
                                    .read<OtpBloc>()
                                    .add(const OtpFieldTapped());
                              },
                              onChanged: (value) {
                                context
                                    .read<OtpBloc>()
                                    .add(OtpCodeChanged(value));
                              },
                              onCompleted: (value) {
                                context
                                    .read<OtpBloc>()
                                    .add(OtpCodeCompleted(int.parse(value)));
                              },
                              forceError:
                                  state.status == OtpStatus.verifyOtpFailed,
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        // Resend code section
                        BlocBuilder<OtpBloc, OtpState>(
                          builder: (context, state) {
                            return ConditionalWidget(
                              condition: state.resendOtpEnabled,
                              onTrue: GestureDetector(
                                onTap: () {
                                  context
                                      .read<OtpBloc>()
                                      .add(const ResendOtpRequested());
                                },
                                child: RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 14,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: 'You can resend the code '),
                                      TextSpan(
                                        text: 'Resend',
                                        style: TextStyle(
                                          color: Color(0xFF4CAF50),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onFalse: Countdown(
                                seconds: state.otpResendDuration,
                                build: (context, time) {
                                  return RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 14,
                                      ),
                                      children: [
                                        const TextSpan(
                                            text: 'You can resend the code '),
                                        TextSpan(
                                          text:
                                              '0:${time.round() < 10 ? '0${time.round()}' : time.round()}',
                                          style: const TextStyle(
                                            color: Color(0xFFFF5252),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                onFinished: () {
                                  context
                                      .read<OtpBloc>()
                                      .add(const ResendOtpDurationFinished());
                                },
                              ),
                            );
                          },
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).viewInsets.bottom > 0
                                ? 20
                                : 60),
                        // Continue button
                        BlocBuilder<OtpBloc, OtpState>(
                          builder: (context, state) {
                            return AppButton(
                              textString: 'Continue',
                              expandButton: true,
                              enabledButtonFilledStyle: BoxDecoration(
                                color: const Color(0xFF2E7D32),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              buttonType: ButtonType.filled,
                              enabledTextStyle: AppTheme.loginText.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              buttonState:
                                  state.status == OtpStatus.otpCodeCompleted
                                      ? ButtonState.enabled
                                      : ButtonState.disabled,
                              onPressed:
                                  state.status == OtpStatus.otpCodeCompleted
                                      ? (_) {
                                          _otpFocusNode.unfocus();
                                          context.read<OtpBloc>().add(
                                                const ValidateOtpRequested(),
                                              );
                                        }
                                      : null,
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _otpFocusNode.requestFocus();
      SystemChannels.textInput.invokeMethod('TextInput.show');
    }
  }

  @override
  void dispose() {
    _otpTextController.dispose();
    _otpFocusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
