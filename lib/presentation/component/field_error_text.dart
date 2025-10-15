import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FieldErrorText extends StatelessWidget {
  final String? errorText;
  const FieldErrorText({super.key, required this.errorText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            color: AppTheme.otpErrorTextColor,
            size: 16,
          ),
          const SizedBox(width: 9.5),
          Flexible(
              child: Text(
            errorText ?? "",
            style: AppTheme.otpFieldErrorText,
          )),
        ],
      ),
    );
  }
}
