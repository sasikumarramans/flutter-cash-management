import 'package:equatable/equatable.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();
}

class EmailIdChanged extends LoginEvent {
  final String emailId;
  const EmailIdChanged(this.emailId);

  @override
  List<Object> get props => [emailId];
}

class EmailIdCompleted extends LoginEvent {
  final String? emailId;
  final bool isValidEmailId;

  const EmailIdCompleted({
    this.emailId,
    required this.isValidEmailId,
  });

  @override
  List<Object?> get props => [emailId, isValidEmailId];
}

class LoginWithEmailRequested extends LoginEvent {
  final bool resendRequest;
  const LoginWithEmailRequested({
    required this.resendRequest,
  });

  @override
  List<Object?> get props => [resendRequest];
}

class ValidateLoginEmailOtpRequested extends LoginEvent {
  final int otpCode;
  const ValidateLoginEmailOtpRequested(this.otpCode);

  @override
  List<Object?> get props => [otpCode];
}
