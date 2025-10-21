import 'dart:async';

import 'package:bearnshare/app/bloc/base/base_bloc.dart';
import 'package:bearnshare/app/helpers/app_file_manager.dart';
import 'package:bearnshare/app/helpers/permissions_manager.dart';
import 'package:bearnshare/app/router/router_manager.dart';
import 'package:bearnshare/domain/group/model/create_group_request.dart';
import 'package:bearnshare/domain/group/model/create_group_response.dart';
import 'package:bearnshare/domain/group/model/search_user_request.dart';
import 'package:bearnshare/domain/group/model/search_user_response.dart';
import 'package:bearnshare/domain/group/use_cases/create_group_use_case.dart';
import 'package:bearnshare/domain/group/use_cases/search_users_use_case.dart';
import 'package:bearnshare/presentation/component/app_image_cropper.dart';
import 'package:bearnshare/presentation/component/media_picker_manager.dart';
import 'package:bearnshare/presentation/create_profile/bloc/profile_event.dart';
import 'package:bearnshare/presentation/split_create_group/bloc/create_group_event.dart';
import 'package:bearnshare/presentation/split_create_group/bloc/create_group_state.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateGroupBloc extends BaseBloc<CreateGroupEvent, CreateGroupState> {
  late final _createGroupUseCase = GetIt.I.get<CreateGroupUseCase>();
  late final _searchUsersUseCase = GetIt.I.get<SearchUsersUseCase>();
  final _routerManager = GetIt.I.get<RouterManager>();
  late final _permissionsManager = GetIt.I.get<PermissionsManager>();
  late final _mediaPickerManager = GetIt.I.get<MediaPickerManager>();
  CancelToken? _searchCancelToken;

  CreateGroupBloc() : super(const CreateGroupState()) {
    on<GroupNameChanged>(_onGroupNameChanged);
    on<CategoryChanged>(_onCategoryChanged);
    on<AddGroupPhoto>(_onAddGroupPhoto);
    on<GroupNameValidationCompleted>(_onGroupNameValidationCompleted);
    on<CreateGroup>(_onCreateGroup);
    on<SearchUsers>(_onSearchUsers);
    on<AddSelectedUser>(_onAddSelectedUser);
    on<RemoveSelectedUser>(_onRemoveSelectedUser);
    on<ClearSearchResults>(_onClearSearchResults);
  }

  @override
  Future<void> close() {
    _searchCancelToken?.cancel();
    return super.close();
  }

  void _onGroupNameChanged(
    GroupNameChanged event,
    Emitter<CreateGroupState> emit,
  ) {
    emit(state.copyWith(
      groupName: event.groupName,
    ));
  }

  void _onCategoryChanged(
    CategoryChanged event,
    Emitter<CreateGroupState> emit,
  ) {
    emit(state.copyWith(category: event.category));
  }

  void _onGroupNameValidationCompleted(
    GroupNameValidationCompleted event,
    Emitter<CreateGroupState> emit,
  ) {
    emit(state.copyWith(isGroupNameEnabled: event.isValid));
  }

  Future<void> _onAddGroupPhoto(
    AddGroupPhoto event,
    Emitter<CreateGroupState> emit,
  ) async {
    List<XFile> medias = [];
    final source = event.mediaPicker;

    if (source == MediaPicker.gallery) {
      final permissionStatus =
          await _permissionsManager.requestGalleryPermission();
      if (!_handlePermission(permissionStatus)) return;
      final XFile? media = await _mediaPickerManager.pickImageFromGallery();
      medias = media != null ? [media] : <XFile>[];
    } else if (source == MediaPicker.camera) {
      final permissionStatus =
          await _permissionsManager.requestCameraPermission();
      if (!_handlePermission(permissionStatus)) return;
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
          aspectRatio: 1 / 1,
          interactive: true,
          maskColor: Colors.black45,
        ),
      ),
    );

    if (croppedImages != null && croppedImages.isNotEmpty) {
      final directory = await getTemporaryDirectory();
      final targetPath = path.join(directory.path,
          'compressed_${path.basenameWithoutExtension(croppedImages[0])}.jpg');

      final compressedFile = await FlutterImageCompress.compressAndGetFile(
          croppedImages[0], targetPath,
          quality: 80, format: CompressFormat.jpeg);

      emit(state.copyWith(
        groupImageFile: compressedFile?.path,
      ));
    }
  }

  bool _handlePermission(PermissionStatus permissionStatus) {
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

  Future<void> _onCreateGroup(
    CreateGroup event,
    Emitter<CreateGroupState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CreateGroupStatus.loading));

      final memberUsernames =
          state.selectedUsers.map((user) => user.username).toList();
      final request = CreateGroupRequest(
        name: state.groupName.trim(),
        description: state.category,
        currency: state.currency,
        memberUsernames: memberUsernames,
      );

      final response = await safeExecute<CreateGroupResponse>(
        function: () async {
          return await _createGroupUseCase.execute(request: request);
        },
        showLoading: true,
        showError: true,
      );

      if (response == null) {
        emit(state.copyWith(
          status: CreateGroupStatus.failed,
          errorMessage: response?.message ?? 'Failed to create group',
        ));
        return;
      }
      emit(state.copyWith(status: CreateGroupStatus.success));
      _routerManager.goRouter.pop();
    } catch (e) {
      emit(state.copyWith(
        status: CreateGroupStatus.failed,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSearchUsers(
    SearchUsers event,
    Emitter<CreateGroupState> emit,
  ) async {
    _searchCancelToken?.cancel();
    if (event.query.trim().isEmpty) {
      emit(state.copyWith(
        searchResults: [],
        searchStatus: SearchStatus.initial,
      ));
      return;
    }
    try {
      emit(state.copyWith(
          searchStatus: SearchStatus.loading, searchQuery: event.query));
      _searchCancelToken = CancelToken();
      final request = SearchUserRequest(query: event.query.trim());

      final response = await safeExecute<SearchUserResponse>(
        function: () async {
          return await _searchUsersUseCase.execute(
              request: request, cancelToken: _searchCancelToken);
        },
        showLoading: false,
        showError: true,
      );
      if (response != null &&
          response.data != null &&
          response.data!.isNotEmpty) {
        emit(state.copyWith(
          searchResults: response.data,
          searchStatus: SearchStatus.success,
        ));
      } else {
        emit(state.copyWith(
          searchResults: [],
          searchStatus: SearchStatus.failed,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        searchResults: [],
        searchStatus: SearchStatus.failed,
      ));
    }
  }

  void _onAddSelectedUser(
    AddSelectedUser event,
    Emitter<CreateGroupState> emit,
  ) {
    final isAlreadySelected =
        state.selectedUsers.any((user) => user.id == event.user.id);

    if (!isAlreadySelected) {
      final updatedSelectedUsers =
          List<SearchUserData>.from(state.selectedUsers)..add(event.user);

      emit(state.copyWith(
        selectedUsers: updatedSelectedUsers,
      ));
    }
  }

  void _onRemoveSelectedUser(
    RemoveSelectedUser event,
    Emitter<CreateGroupState> emit,
  ) {
    final updatedSelectedUsers =
        state.selectedUsers.where((user) => user.id != event.userId).toList();

    emit(state.copyWith(
      selectedUsers: updatedSelectedUsers,
    ));
  }

  void _onClearSearchResults(
    ClearSearchResults event,
    Emitter<CreateGroupState> emit,
  ) {
    emit(state.copyWith(
      searchResults: [],
      searchStatus: SearchStatus.initial,
    ));
  }
}
