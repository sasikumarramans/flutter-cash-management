import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/profile/model/user_data_object.dart';
import 'package:bearnshare/domain/profile/profile_repository.dart';
import 'package:get_it/get_it.dart';

class GetProfileUseCase extends BaseUseCase<String, UserDataObject> {
  final _profileRepository = GetIt.I.get<ProfileRepository>();

  @override
  Future<UserDataObject> execute({dynamic request}) {
    return _profileRepository.getProfileApi();
  }
}
