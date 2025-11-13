import 'package:bearnshare/domain/base/base_use_case.dart';
import 'package:bearnshare/domain/group/group_repository.dart';
import 'package:bearnshare/domain/split_add/model/search_request.dart';
import 'package:bearnshare/domain/split_add/model/search_response.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class SearchUseCase extends BaseUseCase<SearchRequest, SearchResponse> {
  final _groupRepository = GetIt.I.get<GroupRepository>();

  @override
  Future<SearchResponse> execute({
    SearchRequest? request,
    CancelToken? cancelToken,
  }) async {
    return await _groupRepository.search(request!, cancelToken: cancelToken);
  }
}