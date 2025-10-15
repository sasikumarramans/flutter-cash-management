// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bearnshare/domain/auth/auth_repository.dart';
import 'package:bearnshare/domain/auth/login/model/login_otp_response.dart';
import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:get_it/get_it.dart';

class LoginOtpUseCase extends BaseUseCase<LoginOtpRequest, LoginOtpResponse> {
  final _authRepository = GetIt.I<AuthRepository>();

  @override
  Future<LoginOtpResponse> execute({LoginOtpRequest? request}) {
    return _authRepository.loginSendEmailOtp(request!);
  }
}

class LoginOtpRequest {
  final String mobileNumber;

  LoginOtpRequest({
    required this.mobileNumber,
  });

  LoginOtpRequest copyWith({
    String? mobileNumber,
  }) {
    return LoginOtpRequest(
      mobileNumber: mobileNumber ?? this.mobileNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mobileNumber': mobileNumber,
    };
  }

  factory LoginOtpRequest.fromMap(Map<String, dynamic> map) {
    return LoginOtpRequest(
      mobileNumber: map['mobileNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginOtpRequest.fromJson(String source) =>
      LoginOtpRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoginUserRequest(mobileNumber: $mobileNumber)';
}
