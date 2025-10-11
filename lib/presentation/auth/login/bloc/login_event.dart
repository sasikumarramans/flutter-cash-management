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
  final String? mobileNumber;
  final bool isValidMobileNumber;

  const MobileNumberCompleted({
    this.mobileNumber,
    required this.isValidMobileNumber,
  });

  @override
  List<Object?> get props => [mobileNumber, isValidMobileNumber];
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
