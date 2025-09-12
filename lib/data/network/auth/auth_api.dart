import 'package:ev_flutter_app/data/network/core/dio_client.dart';
import 'package:ev_flutter_app/domain/auth/auth_repository.dart';
import 'package:ev_flutter_app/domain/auth/login/model/login_email_otp_response.dart';
import 'package:ev_flutter_app/domain/auth/login/model/login_email_otp_verify_response.dart';
import 'package:ev_flutter_app/domain/auth/login/use_cases/login_send_email_otp_use_case.dart';
import 'package:ev_flutter_app/domain/auth/login/use_cases/verify_login_otp_use_case.dart';
import 'package:get_it/get_it.dart';

class AuthApi extends AuthRepository {
  final _dioClient = GetIt.I<DioClient>();

  static const String pathSendOtpEmail = '/api/ugc/v1/auth/send-otp-email';
  static const String pathVerifyOtpEmail =
      '/api/ugc/v1/auth/verify-email-otp-and-login';

  @override
  Future<LoginEmailOtpResponse> loginSendEmailOtp(
      LoginEmailOtpRequest request) async {
    final loginResponse = await _dioClient.postRequest<LoginEmailOtpResponse>(
      pathSendOtpEmail,
      data: request.toJson(),
      parseDataJson: LoginEmailOtpResponse.fromJson,
    );

    return loginResponse;
  }

  @override
  Future<LoginEmailOtpVerifyResponse> verifyLoginOtp(
      VerifyLoginOtpRequest request) {
    final verifyResponse = _dioClient.postRequest<LoginEmailOtpVerifyResponse>(
      pathVerifyOtpEmail,
      data: request.toJson(),
      parseDataJson: LoginEmailOtpVerifyResponse.fromJson,
    );

    return verifyResponse;
  }
}
