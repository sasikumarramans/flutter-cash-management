import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DraftsCacheManager {
  static const _key = 'drafts_cache_manager';

  final CacheManager _manager = CacheManager(
    Config(
      _key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 20,
      repo: JsonCacheInfoRepository(databaseName: _key),
      fileService: HttpFileService(),
    ),
  );

  CacheManager get instance => _manager;

  Future<void> clearCache() async {
    await _manager.emptyCache();
  }
}
