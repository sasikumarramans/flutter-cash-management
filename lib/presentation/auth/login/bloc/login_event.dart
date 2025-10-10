import 'package:equatable/equatable.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

class MobileNumberChanged extends LoginEvent {
  final String emailId;
  const MobileNumberChanged(this.emailId);

  @override
  List<Object> get props => [emailId];
}

class MobileNumberCompleted extends LoginEvent {
  final String? emailId;
  final bool isValidEmailId;

  const MobileNumberCompleted({
    this.emailId,
    required this.isValidEmailId,
  });

  @override
  List<Object?> get props => [emailId, isValidEmailId];
}

class LoginWithMobileNumberRequested extends LoginEvent {
  final bool resendRequest;
  const LoginWithMobileNumberRequested({
    required this.resendRequest,
  });

  @override
  List<Object?> get props => [resendRequest];
}

class ValidateLoginMobileNumberOtpRequested extends LoginEvent {
  final int otpCode;
  const ValidateLoginMobileNumberOtpRequested(this.otpCode);

  @override
  List<Object?> get props => [otpCode];
}
