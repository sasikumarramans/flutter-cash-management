import 'package:flutter/material.dart';
import 'package:ev_flutter_app/domain/app_update/model/app_update_info.dart';

abstract class AppUpdateRepository {
  Future<AppUpdateModel> getUpdateInfo();
  Future<bool> performSoftUpdate(BuildContext context);
  Future<bool> performForceUpdate(BuildContext context);
}
