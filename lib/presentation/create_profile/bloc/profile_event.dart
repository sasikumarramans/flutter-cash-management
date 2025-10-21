import 'package:equatable/equatable.dart';

enum MediaPicker {
  files,
  gallery,
  camera,
}

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class EmailIdCompleted extends ProfileEvent {
  final bool isValid;
  const EmailIdCompleted({this.isValid = true});
}

class UserNameCompleted extends ProfileEvent {
  final bool isValid;
  const UserNameCompleted(this.isValid);
}

class UserNameEvent extends ProfileEvent {
  final String userName;
  const UserNameEvent(this.userName);
}

class ProfileUpdate extends ProfileEvent {
  const ProfileUpdate();
}

class EmailIdChanged extends ProfileEvent {
  final String emailId;
  const EmailIdChanged(this.emailId);
}

class AddProfilePhoto extends ProfileEvent {
  final MediaPicker? mediaPicker;
  const AddProfilePhoto({this.mediaPicker});
}

class GetProfile extends ProfileEvent {
  const GetProfile();
}
