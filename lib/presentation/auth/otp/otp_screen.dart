import 'package:ev_flutter_app/app/theme/app_theme.dart';
import 'package:ev_flutter_app/generated/l10n.dart';
import 'package:ev_flutter_app/presentation/auth/otp/bloc/otp_bloc.dart';
import 'package:ev_flutter_app/presentation/auth/otp/bloc/otp_event.dart';
import 'package:ev_flutter_app/presentation/auth/otp/bloc/otp_state.dart';
import 'package:ev_flutter_app/presentation/component/app_button.dart';
import 'package:ev_flutter_app/presentation/component/conditional_widget.dart';
import 'package:ev_flutter_app/presentation/component/otp_fields.dart';
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
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            GoRouter.of(context).pop();
          },
          child: SizedBox(
            height: 15,
            width: 15,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Icon(Icons.arrow_back_ios_new),
            ),
          ),
        ),
        shadowColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 35),
                Text(
                  S.of(context).otp_check_your_email,
                  style: AppTheme.otpCheckYourEmail,
                ),
                const SizedBox(height: 12),
                BlocBuilder<OtpBloc, OtpState>(
                  builder: (context, state) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${S.of(context).otp_enter_the_otp_sent_to}: ",
                          style: AppTheme.otpEnterTheCode,
                        ),
                        Text(
                          state.emailId,
                          style: AppTheme.otpEnterTheCode
                              .copyWith(color: Colors.white),
                        )
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
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
                      customDefaultPinTheme: AppTheme.otpDefaultPinTheme,
                      customFocusedPinTheme: AppTheme.otpFocusedPinTheme,
                      customSubmittedPinTheme: AppTheme.otpSubmittedPinTheme,
                      customErrorPinTheme: AppTheme.otpErrorPinTheme,
                      onTap: () {
                        context.read<OtpBloc>().add(const OtpFieldTapped());
                      },
                      onChanged: (value) {
                        context.read<OtpBloc>().add(OtpCodeChanged(value));
                      },
                      onCompleted: (value) {
                        context
                            .read<OtpBloc>()
                            .add(OtpCodeCompleted(int.parse(value)));
                      },
                      forceError: state.status == OtpStatus.verifyOtpFailed,
                    );
                  },
                ),
                const SizedBox(height: 42),
                BlocBuilder<OtpBloc, OtpState>(
                  builder: (context, state) {
                    return ConditionalWidget(
                        condition: state.resendOtpEnabled,
                        onTrue: AppButton(
                          buttonType: ButtonType.filled,
                          completedTextStyle: AppTheme.otpResend,
                          textString: S.of(context).otp_resend_code,
                          buttonState: ButtonState.completed,
                          completedButtonFilledStyle:
                              AppTheme.buttonCompletedFilledFabric,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 6,
                          ),
                          onPressed: (value) {
                            context
                                .read<OtpBloc>()
                                .add(const ResendOtpRequested());
                          },
                        ),
                        onFalse: Countdown(
                          seconds: state.otpResendDuration,
                          build: (context, time) {
                            return AppButton(
                              buttonType: ButtonType.filled,
                              disabledTextStyle: AppTheme.otpResend,
                              disabledButtonFilledStyle:
                                  AppTheme.buttonDisabledFilled.copyWith(
                                color:
                                    AppTheme.otpResendDisabledBackgroundColor,
                              ),
                              textString:
                                  "${S.of(context).otp_resend_in} 00:${time.round() < 10 ? '0${time.round()}' : time.round()}",
                              buttonState: ButtonState.disabled,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 6,
                              ),
                            );
                          },
                          onFinished: () {
                            context
                                .read<OtpBloc>()
                                .add(const ResendOtpDurationFinished());
                          },
                        ));
                  },
                ),
                const Spacer(),
                BlocBuilder<OtpBloc, OtpState>(
                  builder: (context, state) {
                    return AppButton(
                        textString: S.of(context).otp_confirm_email,
                        buttonType: ButtonType.filled,
                        buttonState: state.status == OtpStatus.otpCodeCompleted
                            ? ButtonState.completed
                            : ButtonState.disabled,
                        completedTextStyle: AppTheme.textEnabledTheme.copyWith(
                          color: Colors.white,
                        ),
                        completedButtonFilledStyle:
                            AppTheme.buttonCompletedFilledFabric,
                        expandButton: true,
                        onPressed: (value) {
                          _otpFocusNode.unfocus();
                          context.read<OtpBloc>().add(
                                const ValidateOtpRequested(),
                              );
                        });
                  },
                )
              ],
            ),
          ),
        ],
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
