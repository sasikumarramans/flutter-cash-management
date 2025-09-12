import 'package:get_it/get_it.dart';
import 'package:ev_flutter_app/domain/app_update/app_update_repository.dart';
import 'package:ev_flutter_app/domain/app_update/model/app_update_info.dart';
import 'package:ev_flutter_app/domain/base/base_use_case.dart';

class CheckAppUpdateUseCase implements BaseUseCase<void, AppUpdateModel> {
  final _appUpdateRepository = GetIt.instance.get<AppUpdateRepository>();

  @override
  Future<AppUpdateModel> execute({void request}) async {
    return await _appUpdateRepository.getUpdateInfo();
  }
}
