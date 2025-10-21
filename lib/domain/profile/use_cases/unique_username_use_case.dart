import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/profile/model/unique_user_name_request.dart';
import 'package:bearnshare/domain/profile/model/unique_user_name_response.dart';
import 'package:bearnshare/domain/profile/profile_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class UniqueUsernameUseCase
    extends BaseUseCase<UniqueUserNameRequest, UniqueUserNameResponse> {
  final _profileRepository = GetIt.I.get<ProfileRepository>();

  @override
  Future<UniqueUserNameResponse> execute({
    UniqueUserNameRequest? request,
    CancelToken? cancelToken,
  }) {
    return _profileRepository.isUniqueUsername(request!,
        cancelToken: cancelToken);
  }
}
