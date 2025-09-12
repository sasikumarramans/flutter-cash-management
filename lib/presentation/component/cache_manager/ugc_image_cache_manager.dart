import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class UGCImageCacheManager {
  static const _key = 'ugcImageCache';

  final CacheManager _manager = CacheManager(
    Config(
      _key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 50,
      repo: JsonCacheInfoRepository(databaseName: _key),
      fileService: HttpFileService(),
    ),
  );

  CacheManager get instance => _manager;

  Future<void> clearCache() async {
    await _manager.emptyCache();
  }
}
