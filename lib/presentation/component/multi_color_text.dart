import 'package:flutter/material.dart';

class MultiColorText extends StatelessWidget {
  final List<MapEntry<String, Color>> textParts;
  final TextAlign? textAlign;
  final TextStyle? textStyle;

  const MultiColorText({
    super.key,
    required this.textParts,
    this.textAlign,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.left,
      text: TextSpan(
        children: textParts.map((part) {
          return TextSpan(
            text: part.key,
            style: textStyle!.copyWith(color: part.value),
          );
        }).toList(),
      ),
    );
  }
}
