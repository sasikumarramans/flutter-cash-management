import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/split_add/model/get_splits_request.dart';
import 'package:bearnshare/domain/split_add/model/get_splits_response.dart';
import 'package:bearnshare/domain/split_add/split_repository.dart';
import 'package:get_it/get_it.dart';

class GetSplitsUseCase
    extends BaseUseCase<GetSplitsRequest, GetSplitsResponse> {
  final _splitRepository = GetIt.I.get<SplitRepository>();

  @override
  Future<GetSplitsResponse> execute({GetSplitsRequest? request}) async {
    return await _splitRepository.getSplits(request!);
  }
}