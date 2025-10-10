import 'package:equatable/equatable.dart';

enum LoginStatus {
  unknown,
  authenticatingUser,
  userAuthenticated,
  sendingOtp,
  otpSent,
  sendOtpFailed,
}

class LoginState extends Equatable {
  final LoginStatus status;
  final String? mobileNumber;
  final bool isValidMobileNumber;

  const LoginState({
    this.status = LoginStatus.unknown,
    this.mobileNumber,
    this.isValidMobileNumber = false,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? mobileNumber,
    bool? isValidMobileNumber,
  }) {
    return LoginState(
      status: status ?? this.status,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      isValidMobileNumber: isValidMobileNumber ?? this.isValidMobileNumber,
    );
  }

  @override
  List<Object?> get props => [
        status,
        mobileNumber,
        isValidMobileNumber,
      ];
}
