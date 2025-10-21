import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/group/group_repository.dart';
import 'package:bearnshare/domain/group/model/create_group_request.dart';
import 'package:bearnshare/domain/group/model/create_group_response.dart';
import 'package:get_it/get_it.dart';

class CreateGroupUseCase
    extends BaseUseCase<CreateGroupRequest, CreateGroupResponse> {
  final _groupRepository = GetIt.I.get<GroupRepository>();

  @override
  Future<CreateGroupResponse> execute({dynamic request}) {
    return _groupRepository.createGroup(request!);
  }
}