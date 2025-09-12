import 'package:ev_flutter_app/domain/auth/login/model/login_email_otp_response.dart';
import 'package:ev_flutter_app/domain/auth/login/model/login_email_otp_verify_response.dart';
import 'package:ev_flutter_app/domain/auth/login/use_cases/login_send_email_otp_use_case.dart';
import 'package:ev_flutter_app/domain/auth/login/use_cases/verify_login_otp_use_case.dart';

abstract class AuthRepository {
  Future<LoginEmailOtpResponse> loginSendEmailOtp(LoginEmailOtpRequest request);

  Future<LoginEmailOtpVerifyResponse> verifyLoginOtp(
      VerifyLoginOtpRequest request);
}
