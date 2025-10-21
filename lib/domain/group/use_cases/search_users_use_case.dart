import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/group/group_repository.dart';
import 'package:bearnshare/domain/group/model/search_user_request.dart';
import 'package:bearnshare/domain/group/model/search_user_response.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class SearchUsersUseCase
    extends BaseUseCase<SearchUserRequest, SearchUserResponse> {
  final _groupRepository = GetIt.I.get<GroupRepository>();
  @override
  Future<SearchUserResponse> execute(
      {SearchUserRequest? request, CancelToken? cancelToken}) async {
    return await _groupRepository.searchUsers(request!,
        cancelToken: cancelToken);
  }
}
