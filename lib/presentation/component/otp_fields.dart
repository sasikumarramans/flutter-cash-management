import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/l10n.dart';
import 'package:bearnshare/presentation/component/field_error_text.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpFields extends StatelessWidget {
  final int length;
  final bool obscureText;
  final String? value;
  final bool forceError;
  final bool isAnimateFields;
  final bool isAnimateError;
  final Widget? placeholder;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final Function() onTap;
  final TextEditingController controller;
  final FocusNode? focusNode;

  // Optional themes to override default AppTheme
  final PinTheme? customDefaultPinTheme;
  final PinTheme? customFocusedPinTheme;
  final PinTheme? customSubmittedPinTheme;
  final PinTheme? customErrorPinTheme;

  const OtpFields({
    super.key,
    required this.length,
    this.obscureText = false,
    this.value,
    this.forceError = false,
    this.isAnimateFields = true,
    this.isAnimateError = true,
    this.placeholder,
    this.onChanged,
    this.onCompleted,
    required this.onTap,
    required this.controller,
    this.focusNode,
    this.customDefaultPinTheme,
    this.customFocusedPinTheme,
    this.customSubmittedPinTheme,
    this.customErrorPinTheme,
  });

  @override
  Widget build(BuildContext context) {
    // Use custom theme if provided, otherwise fallback to default AppTheme
    final defaultPinTheme =
        customDefaultPinTheme ?? AppTheme.otpDefaultPinTheme;
    final focusedPinTheme =
        customFocusedPinTheme ?? AppTheme.otpFocusedPinTheme;
    final submittedPinTheme =
        customSubmittedPinTheme ?? AppTheme.otpSubmittedPinTheme;
    final errorPinTheme = customErrorPinTheme ?? AppTheme.otpErrorPinTheme;

    return Pinput(
      length: length,
      controller: controller,
      focusNode: focusNode,
      defaultPinTheme: defaultPinTheme,
      separatorBuilder: (index) => const SizedBox(width: 8),
      onTap: onTap,
      onCompleted: (pin) {
        onCompleted?.call(pin);
      },
      onChanged: (value) {
        onChanged?.call(value);
      },
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: submittedPinTheme,
      errorPinTheme: errorPinTheme,
      autofocus: false,
      errorText: S.of(context).otp_invalid_verification_code,
      errorBuilder: (errorText, pin) {
        return FieldErrorText(
          errorText: errorText,
        );
      },
      forceErrorState: forceError,
      pinAnimationType: PinAnimationType.scale,
      closeKeyboardWhenCompleted: false,
    );
  }
}
