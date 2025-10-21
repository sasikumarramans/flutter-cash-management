import 'package:bearnshare/domain/auth/login/model/login_otp_response.dart';
import 'package:bearnshare/domain/auth/login/model/user_response_object.dart';
import 'package:bearnshare/domain/auth/login/use_cases/login_otp_use_case.dart';
import 'package:bearnshare/domain/auth/login/use_cases/verify_login_otp_use_case.dart';

abstract class AuthRepository {
  Future<LoginOtpResponse> loginSendEmailOtp(LoginOtpRequest request);

  Future<UserResponseObject> verifyLoginOtp(VerifyLoginOtpRequest request);
}
