import 'package:bearnshare/domain/group/model/create_group_request.dart';
import 'package:bearnshare/domain/group/model/create_group_response.dart';
import 'package:bearnshare/domain/group/model/get_groups_request.dart';
import 'package:bearnshare/domain/group/model/get_groups_response.dart';
import 'package:bearnshare/domain/group/model/search_user_request.dart';
import 'package:bearnshare/domain/group/model/search_user_response.dart';
import 'package:dio/dio.dart';

abstract class GroupRepository {
  Future<CreateGroupResponse> createGroup(CreateGroupRequest request);
  Future<SearchUserResponse> searchUsers(SearchUserRequest request,
      {CancelToken? cancelToken});
  Future<GroupsResponse> getGroups(GetGroupsRequest request);
}
