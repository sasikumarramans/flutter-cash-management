import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ev_flutter_app/domain/app_update/app_update_repository.dart';
import 'package:ev_flutter_app/domain/base/base_use_case.dart';

class PerformSoftUpdateUseCase implements BaseUseCase<BuildContext, bool> {
  final _appUpdateRepository = GetIt.instance.get<AppUpdateRepository>();

  @override
  Future<bool> execute({BuildContext? request}) async {
    if (request == null) {
      throw Exception('BuildContext is required');
    }
    return await _appUpdateRepository.performSoftUpdate(request);
  }
}
