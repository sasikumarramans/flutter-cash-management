import 'dart:convert';

import 'package:ev_flutter_app/domain/auth/auth_repository.dart';
import 'package:ev_flutter_app/domain/auth/login/model/login_otp_verify_response.dart';
import 'package:ev_flutter_app/domain/base/base_use_case.dart';
import 'package:get_it/get_it.dart';

class VerifyLoginOtpUseCase
    extends BaseUseCase<VerifyLoginOtpRequest, LoginOtpVerifyResponse> {
  final _authRepository = GetIt.instance.get<AuthRepository>();
  @override
  Future<LoginOtpVerifyResponse> execute({VerifyLoginOtpRequest? request}) {
    return _authRepository.verifyLoginOtp(request!);
  }
}

class VerifyLoginOtpRequest {
  final String mobileNumber;
  final int otpCode;

  VerifyLoginOtpRequest({
    required this.mobileNumber,
    required this.otpCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mobileNumber': mobileNumber,
      'otpCode': otpCode,
    };
  }

  String toJson() => json.encode(toMap());
}
