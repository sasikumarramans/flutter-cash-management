import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LinkTextWidget extends StatelessWidget {
  final List<MapEntry<String, String>> textParts;
  final TextStyle? textStyle;
  final Function(String)? onError;

  const LinkTextWidget({
    super.key,
    required this.textParts,
    this.textStyle,
    this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: textParts.map((entry) {
          if (entry.value.isNotEmpty) {
            return TextSpan(
              text: entry.key,
              style: textStyle?.copyWith(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                  ) ??
                  const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                  ),
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  //webview widget
                },
            );
          } else {
            return TextSpan(
              text: entry.key,
              style: textStyle ?? const TextStyle(color: Colors.black),
            );
          }
        }).toList(),
      ),
    );
  }
}
