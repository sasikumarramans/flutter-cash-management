import 'package:bearnshare/domain/split_add/model/add_split_request.dart';
import 'package:bearnshare/domain/split_add/model/add_split_response.dart';
import 'package:bearnshare/domain/split_add/model/get_splits_request.dart';
import 'package:bearnshare/domain/split_add/model/get_splits_response.dart';

abstract class SplitRepository {
  Future<AddSplitResponse> addSplit(AddSplitRequest request);
  Future<GetSplitsResponse> getSplits(GetSplitsRequest request);
}