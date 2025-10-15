import 'package:bearnshare/domain/app_update/app_update_repository.dart';
import 'package:bearnshare/domain/app_update/model/app_update_info.dart';
import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:get_it/get_it.dart';

class CheckAppUpdateUseCase implements BaseUseCase<void, AppUpdateModel> {
  final _appUpdateRepository = GetIt.instance.get<AppUpdateRepository>();

  @override
  Future<AppUpdateModel> execute({void request}) async {
    return await _appUpdateRepository.getUpdateInfo();
  }
}
