import 'package:bearnshare/domain/profile/model/user_data_object.dart';
import 'package:equatable/equatable.dart';

enum UserNameUniqueApiStatus {
  initial,
  fetchingData,
  fetchedSuccess,
  fetchedNoData,
  fetchingFailed,
}

enum UniqueUserNameStatus {
  initial,
  loading,
  success,
  alreadyPresent,
  error,
}

enum UpdateProfileStatus {
  initial,
  userProfileSuccess,
  userProfileFailed,
  sendingRequest,
}

class ProfileState extends Equatable {
  final bool isUserNameEnabled;
  final bool isEmailEnabled;
  final String userName;
  final String userNameTooltipMessage;
  final String emailId;
  final String fullName;
  final String companyName;
  final String address;
  final UserNameUniqueApiStatus userNameUniqueApiStatus;
  final UniqueUserNameStatus uniqueUserNameStatus;
  final UpdateProfileStatus updateProfileStatus;
  final String? profileImageFile;
  final UserDataObject? userDataObject;

  const ProfileState(
      {this.isUserNameEnabled = false,
      this.isEmailEnabled = false,
      this.userName = '',
      this.emailId = '',
      this.companyName = '',
      this.address = '',
      this.fullName = '',
      this.profileImageFile = "",
      this.userNameTooltipMessage = '',
      this.userDataObject,
      this.uniqueUserNameStatus = UniqueUserNameStatus.initial,
      this.updateProfileStatus = UpdateProfileStatus.initial,
      this.userNameUniqueApiStatus = UserNameUniqueApiStatus.initial});

  ProfileState copyWith(
      {bool? isUserNameEnabled,
      bool? isEmailEnabled,
      String? userName,
      String? companyName,
      String? fullName,
      String? address,
      UserDataObject? userDataObject,
      String? userNameTooltipMessage,
      UserNameUniqueApiStatus? userNameUniqueApiStatus,
      UniqueUserNameStatus? uniqueUserNameStatus,
      UpdateProfileStatus? updateProfileStatus,
      String? profileImageFile,
      String? emailId}) {
    return ProfileState(
      isUserNameEnabled: isUserNameEnabled ?? this.isUserNameEnabled,
      isEmailEnabled: isEmailEnabled ?? this.isEmailEnabled,
      userName: userName ?? this.userName,
      emailId: emailId ?? this.emailId,
      uniqueUserNameStatus: uniqueUserNameStatus ?? this.uniqueUserNameStatus,
      updateProfileStatus: updateProfileStatus ?? this.updateProfileStatus,
      userNameTooltipMessage:
          userNameTooltipMessage ?? this.userNameTooltipMessage,
      userNameUniqueApiStatus:
          userNameUniqueApiStatus ?? this.userNameUniqueApiStatus,
      profileImageFile: profileImageFile ?? this.profileImageFile,
      userDataObject: userDataObject ?? this.userDataObject,
      companyName: companyName ?? this.companyName,
      address: address ?? this.address,
      fullName: fullName ?? this.fullName,
    );
  }

  @override
  List<Object?> get props => [
        isUserNameEnabled,
        isEmailEnabled,
        userName,
        emailId,
        userNameTooltipMessage,
        userNameUniqueApiStatus,
        uniqueUserNameStatus,
        updateProfileStatus,
        profileImageFile,
        userDataObject,
        fullName,
        address,
        companyName,
      ];
}
