import 'package:bearnshare/data/network/core/dio_client.dart';
import 'package:bearnshare/domain/auth/auth_repository.dart';
import 'package:bearnshare/domain/auth/login/model/login_otp_response.dart';
import 'package:bearnshare/domain/auth/login/model/user_response_object.dart';
import 'package:bearnshare/domain/auth/login/use_cases/login_otp_use_case.dart';
import 'package:bearnshare/domain/auth/login/use_cases/verify_login_otp_use_case.dart';
import 'package:get_it/get_it.dart';

class AuthApi extends AuthRepository {
  final _dioClient = GetIt.I<DioClient>();

  static const String pathSendOtp = '/api/auth/send-otp';
  static const String pathVerifyOtp = '/api/auth/verify-otp';

  @override
  Future<LoginOtpResponse> loginSendEmailOtp(LoginOtpRequest request) async {
    final loginResponse = await _dioClient.postRequest<LoginOtpResponse>(
      pathSendOtp,
      data: request.toJson(),
      parseDataJson: LoginOtpResponse.fromJson,
    );

    return loginResponse;
  }

  @override
  Future<UserResponseObject> verifyLoginOtp(VerifyLoginOtpRequest request) {
    final verifyResponse = _dioClient.postRequest<UserResponseObject>(
      pathVerifyOtp,
      data: request.toJson(),
      parseDataJson: UserResponseObject.fromJson,
    );

    return verifyResponse;
  }
}
