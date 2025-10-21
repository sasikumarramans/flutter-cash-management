import 'package:bearnshare/domain/auth/login/model/user_response_object.dart';
import 'package:bearnshare/domain/profile/model/unique_user_name_request.dart';
import 'package:bearnshare/domain/profile/model/unique_user_name_response.dart';
import 'package:bearnshare/domain/profile/model/user_data_object.dart';
import 'package:dio/dio.dart';

abstract class ProfileRepository {
  Future<UniqueUserNameResponse> isUniqueUsername(UniqueUserNameRequest request,
      {CancelToken? cancelToken});
  Future<UserResponseObject> updateProfileApi(dynamic request);
  Future<UserDataObject> getProfileApi();
}
