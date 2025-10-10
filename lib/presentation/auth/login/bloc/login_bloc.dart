import 'dart:async';

import 'package:ev_flutter_app/app/bloc/base/base_bloc.dart';
import 'package:ev_flutter_app/app/helpers/extensions/string_extensions.dart';
import 'package:ev_flutter_app/data/local/hive_manager.dart';
import 'package:ev_flutter_app/data/network/core/api_exception.dart';
import 'package:ev_flutter_app/domain/auth/login/model/login_email_otp_response.dart';
import 'package:ev_flutter_app/domain/auth/login/model/login_email_otp_verify_response.dart';
import 'package:ev_flutter_app/domain/auth/login/use_cases/login_send_email_otp_use_case.dart';
import 'package:ev_flutter_app/domain/auth/login/use_cases/verify_login_otp_use_case.dart';
import 'package:ev_flutter_app/generated/l10n.dart';
import 'package:ev_flutter_app/presentation/auth/login/bloc/login_event.dart';
import 'package:ev_flutter_app/presentation/auth/login/bloc/login_state.dart';
import 'package:ev_flutter_app/presentation/auth/otp/bloc/otp_bloc.dart';
import 'package:ev_flutter_app/presentation/auth/otp/bloc/otp_event.dart';
import 'package:ev_flutter_app/presentation/auth/otp/bloc/otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  late final _loginUserUseCase = getIt.get<LoginSendEmailOtpUseCase>();
  late final _verifyLoginOtpUseCase = getIt.get<VerifyLoginOtpUseCase>();
  late final _otpBloc = getIt.get<OtpBloc>();
  late final _hiveManager = getIt<HiveManager>();

  StreamSubscription<OtpState>? _otpStateStreamSubscription;

  LoginBloc() : super(const LoginState()) {
    on<MobileNumberChanged>(_onMobileNumberChanged);
    on<MobileNumberCompleted>(_onMobileNumberCompleted);
    on<LoginWithMobileNumberRequested>(_onLoginWithMobileNumberRequested);
    on<ValidateLoginMobileNumberOtpRequested>(_onValidateLoginMobileNumberOtpRequested);
    _listenToOtpBloc();
  }

  FutureOr<void> _onMobileNumberChanged(
      MobileNumberChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      mobileNumber: event.emailId.normalizedEmail,
    ));
  }

  FutureOr<void> _onMobileNumberCompleted(
      MobileNumberCompleted event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      isValidMobileNumber: event.isValidEmailId,
    ));
  }

  FutureOr<void> _onLoginWithMobileNumberRequested(
      LoginWithMobileNumberRequested event, Emitter<LoginState> emit) async {
    await _requestOtpForEmail(emit, event.resendRequest);
  }

  FutureOr<void> _requestOtpForEmail(
      Emitter<LoginState> emit, bool resendRequest) async {
    emit(state.copyWith(
      status: LoginStatus.sendingOtp,
    ));

    await safeExecute<LoginEmailOtpResponse>(
      function: () async {
        return await _loginUserUseCase.execute(
          request: LoginEmailOtpRequest(email: state.mobileNumber ?? ''),
        );
      },
      showLoading: true,
      showError: false,
    );

    if (resendRequest) {
      await showSuccessMsg(S.current.otp_verification_code_resent);
    }

    _otpBloc.add(OtpRequested(
      emailId: state.mobileNumber ?? '',
      otpExpireDuration: 60,
    ));
    emit(state.copyWith(
      status: LoginStatus.otpSent,
    ));
  }

  FutureOr<void> _onValidateLoginMobileNumberOtpRequested(
      ValidateLoginMobileNumberOtpRequested event, Emitter<LoginState> emit) async {
    try {
      final response = await safeExecute<LoginEmailOtpVerifyResponse>(
        function: () async {
          return await _verifyLoginOtpUseCase.execute(
            request: VerifyLoginOtpRequest(
              email: state.mobileNumber ?? '',
              otpCode: event.otpCode,
            ),
          );
        },
        showLoading: true,
        showError: false,
      );

      if (response == null) {
        return;
      }

      await showSuccessMsg("Logged in successfully");

      await _hiveManager.saveToHive(
        HiveManager.userSessionTokenKey,
        response.sessionToken,
      );

      await _hiveManager.saveToHive(
        HiveManager.userIdKey,
        response.userId,
      );

      await _hiveManager.saveToHive(
        HiveManager.appSessionId,
        response.appSessionId,
      );
      emit(state.copyWith(status: LoginStatus.userAuthenticated));
    } catch (e) {
      if (e is ApiException) {
        _otpBloc.add(const VerifyOtpFailed());
      } else if (e is BadResponseException) {
        _otpBloc.add(const VerifyOtpFailed());
      }
    }
  }

  void _listenToOtpBloc() {
    _otpStateStreamSubscription = _otpBloc.stream.listen((state) {
      switch (state.status) {
        case OtpStatus.resendOtp:
          add(const LoginWithMobileNumberRequested(resendRequest: true));
          break;
        case OtpStatus.verifyOtp:
          add(ValidateLoginMobileNumberOtpRequested(state.otpCode));
          break;
        default:
          break;
      }
    });
  }

  @override
  Future<void> close() {
    _otpStateStreamSubscription?.cancel();
    return super.close();
  }
}
