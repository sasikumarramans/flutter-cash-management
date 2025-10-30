import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/split_add/model/add_split_request.dart';
import 'package:bearnshare/domain/split_add/model/add_split_response.dart';
import 'package:bearnshare/domain/split_add/split_repository.dart';
import 'package:get_it/get_it.dart';

class AddSplitUseCase
    extends BaseUseCase<AddSplitRequest, AddSplitResponse> {
  final _splitRepository = GetIt.I.get<SplitRepository>();

  @override
  Future<AddSplitResponse> execute({dynamic request}) {
    return _splitRepository.addSplit(request!);
  }
}