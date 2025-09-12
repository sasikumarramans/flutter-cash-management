import 'package:flutter/material.dart';

class MentionTextEditingController extends TextEditingController {
  MentionTextEditingController({super.text});
  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final defaultStyle = style ?? const TextStyle();
    final mentionRegex = RegExp(r'@[\w-]+');

    final spans = <InlineSpan>[];
    int start = 0;

    for (final match in mentionRegex.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(
          text: text.substring(start, match.start),
          style: defaultStyle,
        ));
      }
      spans.add(TextSpan(
        text: match.group(0),
        style: defaultStyle.copyWith(
          color: Colors.orange,
          fontWeight: FontWeight.w600,
        ),
      ));

      start = match.end;
    }
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: defaultStyle,
      ));
    }

    return TextSpan(style: defaultStyle, children: spans);
  }
}
