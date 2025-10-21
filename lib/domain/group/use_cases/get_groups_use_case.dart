import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/group/group_repository.dart';
import 'package:bearnshare/domain/group/model/get_groups_request.dart';
import 'package:bearnshare/domain/group/model/get_groups_response.dart';
import 'package:get_it/get_it.dart';

class GetGroupsUseCase extends BaseUseCase<GetGroupsRequest, GroupsResponse> {
  final _groupRepository = GetIt.I.get<GroupRepository>();

  @override
  Future<GroupsResponse> execute({GetGroupsRequest? request}) async {
    return await _groupRepository.getGroups(request!);
  }
}
