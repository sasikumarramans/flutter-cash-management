import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/generated/l10n.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:flutter/material.dart';

enum AppDialogType {
  logout,
  openFeedback,
  custom,
  deleteAccount;

  String getTitle(S l10n) {
    switch (this) {
      case AppDialogType.logout:
        return l10n.s_logout_title;
      case AppDialogType.openFeedback:
        return l10n.thanks_for_feedback;
      case AppDialogType.custom:
        return "";
      case AppDialogType.deleteAccount:
        return l10n.delete_account;
    }
  }

  String getMessage(S l10n) {
    switch (this) {
      case AppDialogType.logout:
        return "";
      case AppDialogType.openFeedback:
        return l10n.thanks_for_feedback_desc;
      case AppDialogType.custom:
        return "";
      case AppDialogType.deleteAccount:
        return l10n.delete_account_hint;
    }
  }

  String getConfirmText(S l10n) {
    switch (this) {
      case AppDialogType.logout:
        return l10n.s_yes;
      case AppDialogType.openFeedback:
        return l10n.s_okay;
      case AppDialogType.custom:
        return l10n.s_yes;
      case AppDialogType.deleteAccount:
        return "Continue";
    }
  }

  String getNegativeText(S l10n) {
    switch (this) {
      case AppDialogType.logout:
        return l10n.s_no;
      case AppDialogType.openFeedback:
        return "";
      case AppDialogType.custom:
        return l10n.s_no;
      case AppDialogType.deleteAccount:
        return "Cancel";
    }
  }
}

class AppDialog extends StatelessWidget {
  final AppDialogType type;
  final String? customTitle;
  final BoxDecoration? confirmButtonDecoration;
  final BoxDecoration? negativeButtonDecoration;
  final TextStyle? confirmTextStyle;
  final TextStyle? negativeTextStyle;
  final String? customMessage;
  final String? customConfirmText;
  final String? customCancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool barrierDismissible;
  final Widget? infoImage;

  const AppDialog({
    super.key,
    required this.type,
    this.customTitle,
    this.customCancelText,
    this.customMessage,
    this.customConfirmText,
    this.onConfirm,
    this.onCancel,
    this.confirmButtonDecoration,
    this.negativeButtonDecoration,
    this.confirmTextStyle,
    this.negativeTextStyle,
    this.infoImage,
    this.barrierDismissible = false,
  });

  void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final S l10n = S.of(context);
    return Dialog(
      backgroundColor: Colors.black,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (type == AppDialogType.openFeedback)
              const SizedBox(
                height: 20,
              ),
            if (infoImage != null)
              const SizedBox(
                height: 10,
              ),
            if (infoImage != null)
              Container(
                child: infoImage,
              ),
            const SizedBox(
              height: 20,
            ),
            Text(
              customTitle ?? type.getTitle(l10n),
              textAlign: TextAlign.center,
              style: AppTheme.dialogTitleStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            if (type != AppDialogType.logout)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  customMessage ?? type.getMessage(l10n),
                  textAlign: TextAlign.center,
                  style: AppTheme.dialogMessageStyle,
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              buttonType: ButtonType.filled,
              enabledButtonFilledStyle:
                  confirmButtonDecoration ?? AppTheme.logoutButtonEnabledFilled,
              textString: customConfirmText ?? type.getConfirmText(l10n),
              onPressed: (value) {
                Navigator.pop(context);
                onConfirm?.call();
              },
              buttonState: ButtonState.enabled,
              expandButton: true,
              enabledTextStyle: confirmTextStyle ??
                  AppTheme.dialogMessageStyle.copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            if (type != AppDialogType.openFeedback)
              AppButton(
                  buttonType: ButtonType.filled,
                  enabledButtonFilledStyle: negativeButtonDecoration ??
                      AppTheme.logoutNegativeButtonEnabledFilled,
                  textString: customCancelText ?? type.getNegativeText(l10n),
                  onPressed: (value) {
                    Navigator.pop(context);
                    onCancel?.call();
                  },
                  buttonState: ButtonState.enabled,
                  expandButton: true,
                  enabledTextStyle: negativeTextStyle ??
                      AppTheme.dialogMessageStyle
                          .copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
