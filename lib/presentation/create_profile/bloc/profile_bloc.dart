import 'dart:async';
import 'dart:io';

import 'package:bearnshare/app/bloc/base/base_bloc.dart';
import 'package:bearnshare/app/helpers/app_file_manager.dart';
import 'package:bearnshare/app/helpers/extensions/string_extensions.dart';
import 'package:bearnshare/app/helpers/permissions_manager.dart';
import 'package:bearnshare/app/router/router_manager.dart';
import 'package:bearnshare/data/local/hive_manager.dart';
import 'package:bearnshare/domain/auth/login/model/user_response_object.dart';
import 'package:bearnshare/domain/profile/model/unique_user_name_request.dart';
import 'package:bearnshare/domain/profile/model/unique_user_name_response.dart';
import 'package:bearnshare/domain/profile/model/user_data_object.dart';
import 'package:bearnshare/domain/profile/use_cases/get_profile_use_case.dart';
import 'package:bearnshare/domain/profile/use_cases/unique_username_use_case.dart';
import 'package:bearnshare/domain/profile/use_cases/update_profile_use_case.dart';
import 'package:bearnshare/presentation/component/app_image_cropper.dart';
import 'package:bearnshare/presentation/component/media_picker_manager.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_event.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_state.dart';
import 'package:bearnshare/presentation/main_router.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  CancelToken? _userNameCancelToken;
  late final _hiveManager = getIt.get<HiveManager>();
  late final _uniqueUsernameUseCase = GetIt.I.get<UniqueUsernameUseCase>();
  late final _updateProfileUseCases = GetIt.I.get<UpdateProfileUseCase>();
  late final _getProfileUseCases = GetIt.I.get<GetProfileUseCase>();
  final _routerManager = GetIt.I.get<RouterManager>();
  late final _permissionsManager = GetIt.I.get<PermissionsManager>();
  late final _mediaPickerManager = GetIt.I.get<MediaPickerManager>();

  ProfileBloc() : super(const ProfileState()) {
    on<UserNameEvent>(_userNameChanged);
    on<ProfileUpdate>(_onUpdateProfile);
    on<EmailIdCompleted>(_onEmailCompleted);
    on<UserNameCompleted>(_onUserNameCompleted);
    on<AddProfilePhoto>(_addReferenceImages);
    on<EmailIdChanged>(_onEmailIdChanged);
    on<GetProfile>(_onGetProfile);
  }
  Future<void> _onUserNameCompleted(
    UserNameCompleted event,
    Emitter<ProfileState> emit,
  ) async {
    if (!event.isValid) {
      emit(state.copyWith(
        isUserNameEnabled: false,
      ));
      return;
    }
  }

  FutureOr<void> _onEmailIdChanged(
      EmailIdChanged event, Emitter<ProfileState> emit) {
    emit(state.copyWith(
      emailId: event.emailId.normalizedEmail,
    ));
  }

  Future<void> _addReferenceImages(
      AddProfilePhoto event, Emitter<ProfileState> emit) async {
    List<XFile> medias = [];
    final source = event.mediaPicker;
    if (source == MediaPicker.gallery) {
      final permissionStatus =
          await _permissionsManager.requestGalleryPermission();
      if (!handlePermission(permissionStatus)) return;
      final XFile? media = await _mediaPickerManager.pickImageFromGallery();
      medias = media != null ? [media] : <XFile>[];
    } else if (source == MediaPicker.camera) {
      final permissionStatus =
          await _permissionsManager.requestCameraPermission();
      if (!handlePermission(permissionStatus)) return;
      final XFile? media = await _mediaPickerManager.pickImageFromCamera();
      if (media != null) {
        medias = [media];
      }
    } else if (source == MediaPicker.files) {
      final XFile? media = await _mediaPickerManager.pickImageFromFiles();
      medias = media != null ? [media] : <XFile>[];
    }

    final List<String> imagePaths = [];
    for (var media in medias) {
      final bytes = await media.readAsBytes();
      final Map<String, String> result =
          await GetIt.I.get<AppFileManager>().saveMedia(
                AppFileManager.DIR_NEW_FABRIC,
                bytes,
                MediaExtension.jpg,
              );
      imagePaths.add(result.values.first);
    }

    final List<String> savePaths = List.generate(
      imagePaths.length,
      (index) => AppFileManager.DIR_NEW_FABRIC_CROPPED,
    );

    if (savePaths.isEmpty) {
      return;
    }

    final context = GetIt.I
        .get<RouterManager>()
        .goRouter
        .routerDelegate
        .navigatorKey
        .currentContext!;

    final List<String>? croppedImages = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppImageCropper(
          imagePaths: imagePaths,
          savePaths: savePaths,
          aspectRatio: 9 / 16,
          interactive: true,
          maskColor: Colors.black45,
        ),
      ),
    );

    if (croppedImages != null && croppedImages.isNotEmpty) {
      final directory = await getTemporaryDirectory();
      final targetPath = path.join(
          directory.path, 'compressed_${path.basename(croppedImages[0])}.jpg');
      final String fileExtension =
          path.extension(croppedImages[0]).toLowerCase();

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
          croppedImages[0], targetPath,
          quality: 80, format: CompressFormat.jpeg);
      print(getFileSize(File(compressedFile!.path)));
      print("compressedFile");

      emit(state.copyWith(
        profileImageFile: compressedFile.path,
      ));
    }
  }

  double getFileSize(File file) {
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }

  bool handlePermission(PermissionStatus permissionStatus) {
    if (permissionStatus.isGranted || permissionStatus.isLimited) {
      return true;
    } else if (permissionStatus.isDenied) {
      return false;
    } else if (permissionStatus.isPermanentlyDenied) {
      GetIt.I<PermissionsManager>().openSettings();
      return false;
    } else {
      return false;
    }
  }

  Future<void> _onEmailCompleted(
    EmailIdCompleted event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      isEmailEnabled: event.isValid,
    ));
  }

  Future<void> _userNameChanged(
      UserNameEvent event, Emitter<ProfileState> emit) async {
    try {
      _userNameCancelToken?.cancel();
      _userNameCancelToken = CancelToken();
      if (event.userName.isEmpty) {
        emit(state.copyWith(
            userNameUniqueApiStatus: UserNameUniqueApiStatus.initial,
            uniqueUserNameStatus: UniqueUserNameStatus.initial,
            isUserNameEnabled: false));
        return;
      }

      if (event.userName.length < 3) {
        emit(state.copyWith(
            userNameUniqueApiStatus: UserNameUniqueApiStatus.fetchedSuccess,
            uniqueUserNameStatus: UniqueUserNameStatus.error,
            userNameTooltipMessage: "Username must be at\n least 3 characters",
            isUserNameEnabled: false));
        return;
      }
      emit(state.copyWith(
          userNameUniqueApiStatus: UserNameUniqueApiStatus.fetchingData,
          uniqueUserNameStatus: UniqueUserNameStatus.loading,
          userName: event.userName,
          isUserNameEnabled: false));

      final request = UniqueUserNameRequest(
        userName: event.userName,
      );

      final uniqueUserNameStatus = await safeExecute<UniqueUserNameResponse>(
        function: () async {
          return await _uniqueUsernameUseCase.execute(
            request: request,
            cancelToken: _userNameCancelToken,
          );
        },
      );

      if (uniqueUserNameStatus != null) {
        if (uniqueUserNameStatus.success) {
          emit(state.copyWith(
              userNameUniqueApiStatus: UserNameUniqueApiStatus.fetchedSuccess,
              uniqueUserNameStatus: UniqueUserNameStatus.success,
              userNameTooltipMessage: "Available",
              isUserNameEnabled: true,
              userName: state.userName));
        } else {
          emit(state.copyWith(
              userNameUniqueApiStatus: UserNameUniqueApiStatus.fetchedNoData,
              uniqueUserNameStatus: UniqueUserNameStatus.alreadyPresent,
              userNameTooltipMessage: "Already taken",
              isUserNameEnabled: false));
        }
      } else {
        emit(state.copyWith(
            userNameUniqueApiStatus: UserNameUniqueApiStatus.fetchingFailed,
            uniqueUserNameStatus: UniqueUserNameStatus.error,
            isUserNameEnabled: false,
            userNameTooltipMessage: "Try again"));
      }
    } catch (e) {
      emit(state.copyWith(
          userNameUniqueApiStatus: UserNameUniqueApiStatus.fetchingFailed,
          uniqueUserNameStatus: UniqueUserNameStatus.error,
          isUserNameEnabled: false,
          userNameTooltipMessage: e.toString()));
    }
  }

  Future<void> _onGetProfile(
    GetProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(state.copyWith(
        updateProfileStatus: UpdateProfileStatus.sendingRequest,
      ));
      final response = await safeExecute<UserDataObject>(
        function: () async {
          return await _getProfileUseCases.execute();
        },
        showLoading: false,
        showError: false,
      );
      if (response == null) {
        emit(state.copyWith(
          updateProfileStatus: UpdateProfileStatus.userProfileFailed,
        ));
        return;
      }
      emit(state.copyWith(
          updateProfileStatus: UpdateProfileStatus.userProfileSuccess,
          userDataObject: response));
    } catch (e) {
      emit(state.copyWith(
        updateProfileStatus: UpdateProfileStatus.userProfileFailed,
      ));
    }
  }

  Future<void> _onUpdateProfile(
    ProfileUpdate event,
    Emitter<ProfileState> emit,
  ) async {
    final Map<String, dynamic> fields = {};
    try {
      print(state.emailId);
      print(state.userName);
      print(state.profileImageFile);
      emit(state.copyWith(
        updateProfileStatus: UpdateProfileStatus.sendingRequest,
      ));
      fields.addEntries([
        MapEntry("username", state.userName),
      ]);
      fields.addEntries([
        MapEntry(
          "email",
          state.isEmailEnabled ? state.emailId : "",
        )
      ]);
      if (state.profileImageFile != null) {
        fields.addEntries([
          MapEntry(
            "profileImage",
            await MultipartFile.fromFile(state.profileImageFile!,
                contentType: DioMediaType("image", "jpeg")),
          ),
        ]);
      }

      final response = await safeExecute<UserResponseObject>(
        function: () async {
          return await _updateProfileUseCases.execute(
            request: FormData.fromMap(fields),
          );
        },
        showLoading: true,
        showError: true,
      );
      if (response == null) {
        emit(state.copyWith(
          updateProfileStatus: UpdateProfileStatus.userProfileFailed,
        ));
        return;
      }
      emit(state.copyWith(
        updateProfileStatus: UpdateProfileStatus.userProfileSuccess,
      ));
      GetIt.I<HiveManager>().saveToHive(HiveManager.profileUpdatedKey, true);
      _routerManager.goRouter.go(MainRouter.mainScreenRoute);
    } catch (e) {
      emit(state.copyWith(
        updateProfileStatus: UpdateProfileStatus.userProfileFailed,
      ));
    }
  }
}
