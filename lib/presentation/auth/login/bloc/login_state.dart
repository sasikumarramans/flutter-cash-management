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
  final String? emailId;
  final bool isValidEmailId;
  const LoginState({
    this.status = LoginStatus.unknown,
    this.emailId,
    this.isValidEmailId = false,
  });

  LoginState copyWith({
    LoginStatus? status,
    String? emailId,
    bool? isValidEmailId,
  }) {
    return LoginState(
      status: status ?? this.status,
      emailId: emailId ?? this.emailId,
      isValidEmailId: isValidEmailId ?? this.isValidEmailId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        emailId,
        isValidEmailId,
      ];
}
