import 'package:flutter/material.dart';
import 'package:ev_flutter_app/app/theme/app_theme.dart';

class InlineContentItem {
  final String? text;
  final Widget? icon;
  final TextStyle? textStyle;
  final EdgeInsets? iconPadding;

  InlineContentItem.text({
    required this.text,
    this.textStyle,
  })  : icon = null,
        iconPadding = null;

  InlineContentItem.icon({
    required this.icon,
    this.iconPadding,
  })  : text = null,
        textStyle = null;
}

class AppRichTextAndIcons extends StatelessWidget {
  final List<InlineContentItem> items;
  final TextStyle textStyle;
  final EdgeInsets defaultIconPadding;
  final TextAlign textAlign;

  AppRichTextAndIcons({
    super.key,
    required this.items,
    TextStyle? textStyle,
    this.defaultIconPadding = const EdgeInsets.symmetric(horizontal: 4.0),
    this.textAlign = TextAlign.center,
  }) : textStyle = textStyle ??
            AppTheme.simpleWhiteTextStyle
                .copyWith(color: const Color(0x4debebf5), fontSize: 17);

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> spans = [];
    for (var item in items) {
      if (item.text != null) {
        spans.add(
          TextSpan(
            text: item.text,
            style: item.textStyle ?? textStyle,
          ),
        );
      } else if (item.icon != null) {
        spans.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: item.iconPadding ?? defaultIconPadding,
              child: item.icon!,
            ),
          ),
        );
      }
    }
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: textStyle,
        children: spans,
      ),
    );
  }
}
