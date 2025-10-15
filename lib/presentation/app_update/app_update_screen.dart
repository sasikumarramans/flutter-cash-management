import 'package:bearnshare/app/helpers/extensions/string_extensions.dart';
import 'package:bearnshare/app/router/router_manager.dart';
import 'package:bearnshare/app/theme/app_theme.dart';
import 'package:bearnshare/domain/app_update/model/app_update_info.dart';
import 'package:bearnshare/generated/l10n.dart';
import 'package:bearnshare/presentation/app_update/bloc/app_update_bloc.dart';
import 'package:bearnshare/presentation/app_update/bloc/app_update_event.dart';
import 'package:bearnshare/presentation/app_update/bloc/app_update_state.dart';
import 'package:bearnshare/presentation/component/app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AppUpdateManager extends StatefulWidget {
  final Widget child;

  const AppUpdateManager({
    super.key,
    required this.child,
  });

  @override
  State<AppUpdateManager> createState() => _AppUpdateManagerState();
}

class _AppUpdateManagerState extends State<AppUpdateManager> {
  bool _hasCheckedForUpdate = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppUpdateBloc, AppUpdateState>(
      listener: (context, state) {
        if (state.status == AppUpdateStatus.required) {
          if (!kDebugMode) {
            _showForceUpdateDialog(context, state.updateInfo!);
          }
        } else if (state.status == AppUpdateStatus.available) {
          if (!kDebugMode) {
            _showUpdateAvailableDialog(context, state.updateInfo!);
          }
        }
      },
      builder: (context, state) {
        if (!_hasCheckedForUpdate) {
          _hasCheckedForUpdate = true;
          Future.microtask(
              () => context.read<AppUpdateBloc>().add(CheckForUpdate()));
        }

        return widget.child;
      },
    );
  }

  void _showUpdateAvailableDialog(
      BuildContext context, AppUpdateModel updateInfo) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigatorKey =
          GetIt.I<RouterManager>().goRouter.routerDelegate.navigatorKey;
      final context = navigatorKey.currentContext;
      if (context != null) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (dialogContext) => Dialog(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    S.of(context).update_available,
                    style: AppTheme.dialogTitleStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    updateInfo.updateMessage.isNullOrEmpty
                        ? "The newest version of the app is available"
                        : updateInfo.updateMessage,
                    textAlign: TextAlign.center,
                    style: AppTheme.dialogMessageStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppButton(
                    buttonType: ButtonType.filled,
                    enabledButtonFilledStyle: AppTheme.logoutButtonEnabledFilled
                        .copyWith(color: AppTheme.buttonCompleted),
                    textString: S.of(context).update_now,
                    onPressed: (value) {
                      context.read<AppUpdateBloc>().add(PerformUpdate(context));
                      Navigator.pop(context);
                    },
                    buttonState: ButtonState.enabled,
                    expandButton: true,
                    enabledTextStyle: AppTheme.dialogMessageStyle
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AppButton(
                      buttonType: ButtonType.filled,
                      enabledButtonFilledStyle:
                          AppTheme.logoutNegativeButtonEnabledFilled,
                      textString: S.of(context).later,
                      onPressed: (value) {
                        Navigator.pop(context);
                      },
                      buttonState: ButtonState.enabled,
                      expandButton: true,
                      enabledTextStyle: AppTheme.dialogMessageStyle
                          .copyWith(color: Colors.white)),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  void _showForceUpdateDialog(BuildContext context, AppUpdateModel updateInfo) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final navigatorKey =
          GetIt.I<RouterManager>().goRouter.routerDelegate.navigatorKey;
      final context = navigatorKey.currentContext;
      if (context != null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (dialogContext) => WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      S.of(context).update_required,
                      style: AppTheme.dialogTitleStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      updateInfo.updateMessage.isNullOrEmpty
                          ? "The newest version of the app is available"
                          : updateInfo.updateMessage,
                      textAlign: TextAlign.center,
                      style: AppTheme.dialogMessageStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppButton(
                      buttonType: ButtonType.filled,
                      enabledButtonFilledStyle: AppTheme
                          .logoutButtonEnabledFilled
                          .copyWith(color: AppTheme.buttonCompleted),
                      textString: S.of(context).update_now,
                      onPressed: (value) {
                        context
                            .read<AppUpdateBloc>()
                            .add(PerForceUpdate(context));
                      },
                      buttonState: ButtonState.enabled,
                      expandButton: true,
                      enabledTextStyle: AppTheme.dialogMessageStyle
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    });
  }
}
