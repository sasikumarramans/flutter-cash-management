import 'package:bearnshare/app/helpers/extensions/context_extension.dart';
import 'package:bearnshare/app/router/router_manager.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AppSnackBarManager {
  BuildContext? get context => GetIt.I<RouterManager>()
      .goRouter
      .routerDelegate
      .navigatorKey
      .currentContext;

  Future<void> showSuccess(String message) async {
    context?.showSuccessSnackBar(message);
  }

  Future<void> showError(String message) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context?.showErrorSnackBar(message);
    });
  }

  Future<void> showFavoriteSnackBar(
      String collectionName, bool isFavorite, VoidCallback? onTap) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context?.showFavoriteSnackBar(collectionName, isFavorite, onTap);
    });
  }

  void showLoading() {
    context?.loaderOverlay.show();
  }

  void hideLoading() {
    context?.loaderOverlay.hide();
  }
}
