import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppIosMessageDialog extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final String? subtitle;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final List<Widget>? actions;
  final ButtonStyle? positiveButtonStyle;
  final ButtonStyle? negativeButtonStyle;
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? actionsPadding;
  final bool showCancel;
  final bool showDivider;

  const AppIosMessageDialog({
    super.key,
    this.icon,
    this.title,
    this.subtitle,
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.actions,
    this.positiveButtonStyle,
    this.negativeButtonStyle,
    this.backgroundColor,
    this.borderRadius,
    this.contentPadding,
    this.actionsPadding,
    this.showCancel = false,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final double effectiveRadius = borderRadius ?? 30;
    final EdgeInsets effectiveContentPadding = contentPadding is EdgeInsets
        ? contentPadding as EdgeInsets
        : const EdgeInsets.all(0);
    return IntrinsicHeight(
      child: Dialog(
        insetPadding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
        backgroundColor: backgroundColor ?? Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(effectiveRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(effectiveRadius),
                color: AppTheme.tertiaryBackgroundColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null)
                    Padding(
                      padding: effectiveContentPadding,
                      child: icon,
                    ),
                  if (icon != null) const SizedBox(height: 16),
                  const SizedBox(height: 10),
                  if (title != null)
                    Padding(
                      padding: effectiveContentPadding,
                      child: Text(
                        title!,
                        style: titleTextStyle ??
                            AppTheme.simpleWhiteTextStyle
                                .copyWith(fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  if (title != null && subtitle != null)
                    //  const SizedBox(height: 8),
                    if (subtitle != null)
                      Padding(
                        padding: effectiveContentPadding,
                        child: Text(
                          subtitle!,
                          style: subtitleTextStyle ??
                              AppTheme.simpleWhiteTextStyle
                                  .copyWith(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  const SizedBox(height: 16),
                  if (actions != null)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: actions!.map((action) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (showDivider)
                              const Divider(color: Color(0xB2808080)),
                            Padding(
                              padding: actionsPadding ??
                                  const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 0.0,
                                  ),
                              child: action,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
            if (showCancel) ...[
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(effectiveRadius),
                    color: AppTheme.tertiaryBackgroundColor,
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "Cancel",
                    style: AppTheme.simpleWhiteTextStyle
                        .copyWith(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ] else
              const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
