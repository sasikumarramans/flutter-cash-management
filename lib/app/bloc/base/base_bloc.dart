import 'package:ev_flutter_app/app/helpers/app_snack_bar_manager.dart';
import 'package:ev_flutter_app/data/network/core/api_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  @protected
  final GetIt getIt = GetIt.I;

  @protected
  final Logger logger = Logger();

  BaseBloc(super.initialState);

  @protected
  Future<T?> safeExecute<T>({
    required Future<T> Function() function,
    showError = false,
    showLoading = false,
  }) async {
    if (showLoading) {
      getIt<AppSnackBarManager>().showLoading();
    }

    try {
      final result = await function();

      if (showLoading) {
        getIt<AppSnackBarManager>().hideLoading();
      }

      return result;
    } catch (e, st) {
      if (showLoading) {
        getIt<AppSnackBarManager>().hideLoading();
      }

      logger.e('$function', error: e, stackTrace: st);

      String message = e.toString();

      switch (e.runtimeType) {
        case BadResponseException _:
          rethrow;
        case ApiException _:
          final apiException = e as ApiException;
          message = apiException.message ?? '';

          break;
        default:
      }

      if (showError) {
        await showErrorMsg(message);
        return null;
      } else {
        rethrow;
      }
    }
  }

  @protected
  Future<void> showErrorMsg(String message) async {
    await getIt<AppSnackBarManager>().showError(message);
  }

  Future<void> showSuccessMsg(String message) async {
    await getIt<AppSnackBarManager>().showSuccess(message);
  }
}
