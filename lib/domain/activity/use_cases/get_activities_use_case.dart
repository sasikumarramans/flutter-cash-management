import 'package:bearnshare/domain/activity/activity_repository.dart';
import 'package:bearnshare/domain/activity/model/get_activities_request.dart';
import 'package:bearnshare/domain/activity/model/get_activities_response.dart';
import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:get_it/get_it.dart';

class GetActivitiesUseCase extends BaseUseCase<GetActivitiesRequest, ActivitiesResponse> {
  final _activityRepository = GetIt.I.get<ActivityRepository>();

  @override
  Future<ActivitiesResponse> execute({GetActivitiesRequest? request}) async {
    return await _activityRepository.getActivities(request!);
  }
}