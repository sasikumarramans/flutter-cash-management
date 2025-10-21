import 'package:bearnshare/domain/auth/login/model/user_response_object.dart';
import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/profile/profile_repository.dart';
import 'package:get_it/get_it.dart';

class UpdateProfileUseCase extends BaseUseCase<String, UserResponseObject> {
  final _profileRepository = GetIt.I.get<ProfileRepository>();

  @override
  Future<UserResponseObject> execute({dynamic request}) {
    return _profileRepository.updateProfileApi(request!);
  }
}
