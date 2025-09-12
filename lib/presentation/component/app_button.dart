import 'package:flutter/material.dart';
import 'package:ev_flutter_app/app/theme/app_theme.dart';

enum ButtonState {
  enabled,
  disabled,
  loading,
  completed,
}

enum ButtonType {
  filled,
  outlined,
}

class AppButton extends StatefulWidget {
  final ButtonType buttonType;
  final String textString;
  final Widget? leadingIcon;
  final Widget? actionIcon;
  final bool expandButton;
  final Function(dynamic)? onPressed;
  final ButtonState buttonState;
  final EdgeInsets? padding;

  final TextStyle? enabledTextStyle;
  final TextStyle? disabledTextStyle;
  final TextStyle? loadingTextStyle;
  final TextStyle? completedTextStyle;

  final BoxDecoration? enabledButtonFilledStyle;
  final BoxDecoration? disabledButtonFilledStyle;
  final BoxDecoration? loadingButtonFilledStyle;
  final BoxDecoration? completedButtonFilledStyle;

  final BoxDecoration? enabledButtonOutlinedStyle;
  final BoxDecoration? disabledButtonOutlinedStyle;
  final BoxDecoration? loadingButtonOutlinedStyle;
  final BoxDecoration? completedButtonOutlinedStyle;
  const AppButton({
    super.key,
    required this.textString,
    this.buttonType = ButtonType.filled,
    this.leadingIcon,
    this.actionIcon,
    this.expandButton = false,
    this.onPressed,
    this.buttonState = ButtonState.enabled,
    this.padding,
    this.enabledTextStyle,
    this.disabledTextStyle,
    this.loadingTextStyle,
    this.completedTextStyle,
    this.enabledButtonFilledStyle,
    this.disabledButtonFilledStyle,
    this.loadingButtonFilledStyle,
    this.completedButtonFilledStyle,
    this.enabledButtonOutlinedStyle,
    this.disabledButtonOutlinedStyle,
    this.loadingButtonOutlinedStyle,
    this.completedButtonOutlinedStyle,
  });

  @override
  AppButtonState createState() => AppButtonState();
}

class AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    final TextStyle currentTextStyle;
    switch (widget.buttonState) {
      case ButtonState.enabled:
        currentTextStyle = widget.enabledTextStyle ?? AppTheme.textEnabledTheme;
        break;
      case ButtonState.disabled:
        currentTextStyle =
            widget.disabledTextStyle ?? AppTheme.textDisabledTheme;
        break;
      case ButtonState.loading:
        currentTextStyle = widget.loadingTextStyle ?? AppTheme.textLoadingTheme;
        break;
      case ButtonState.completed:
        currentTextStyle =
            widget.completedTextStyle ?? AppTheme.textCompletedTheme;
        break;
    }

    final BoxDecoration currentButtonStyle;
    if (widget.buttonType == ButtonType.filled) {
      switch (widget.buttonState) {
        case ButtonState.enabled:
          currentButtonStyle =
              widget.enabledButtonFilledStyle ?? AppTheme.buttonEnabledFilled;
          break;
        case ButtonState.disabled:
          currentButtonStyle =
              widget.disabledButtonFilledStyle ?? AppTheme.buttonDisabledFilled;
          break;
        case ButtonState.loading:
          currentButtonStyle =
              widget.loadingButtonFilledStyle ?? AppTheme.buttonLoadingFilled;
          break;
        case ButtonState.completed:
          currentButtonStyle = widget.completedButtonFilledStyle ??
              AppTheme.buttonCompletedFilledFabric;
          break;
      }
    } else {
      switch (widget.buttonState) {
        case ButtonState.enabled:
          currentButtonStyle = widget.enabledButtonOutlinedStyle ??
              AppTheme.buttonEnabledOutlined;
          break;
        case ButtonState.disabled:
          currentButtonStyle = widget.disabledButtonOutlinedStyle ??
              AppTheme.buttonDisabledOutlined;
          break;
        case ButtonState.loading:
          currentButtonStyle = widget.loadingButtonOutlinedStyle ??
              AppTheme.buttonLoadingOutlined;
          break;
        case ButtonState.completed:
          currentButtonStyle = widget.completedButtonOutlinedStyle ??
              AppTheme.buttonCompletedOutlined;
          break;
      }
    }

    final EdgeInsets currentPadding = widget.padding ??
        const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        );

    return InkWell(
      onTap: () {
        if ([ButtonState.enabled, ButtonState.completed]
            .contains(widget.buttonState)) {
          widget.onPressed?.call(widget.textString);
        }
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
          width: widget.expandButton ? double.infinity : null,
          decoration: currentButtonStyle,
          padding: currentPadding,
          child: widget.buttonState == ButtonState.loading
              ? const Center(
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 4.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.leadingIcon != null) ...[
                      widget.leadingIcon!,
                      const SizedBox(width: 8),
                    ],
                    Flexible(
                      child: Text(
                        widget.textString,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: currentTextStyle,
                        strutStyle: const StrutStyle(
                          forceStrutHeight: true,
                          height: 1.0,
                          leading: 0,
                        ),
                      ),
                    ),
                    if (widget.actionIcon != null) ...[
                      const SizedBox(width: 8),
                      widget.actionIcon!,
                    ],
                  ],
                )),
    );
  }
}
