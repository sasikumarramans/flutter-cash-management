import 'package:bearnshare/domain/app_update/model/app_update_info.dart';
import 'package:flutter/material.dart';

abstract class AppUpdateRepository {
  Future<AppUpdateModel> getUpdateInfo();
  Future<bool> performSoftUpdate(BuildContext context);
  Future<bool> performForceUpdate(BuildContext context);
}
