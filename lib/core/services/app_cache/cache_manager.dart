import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// A constant key used for identifying the cache related to reels.
const kReelCacheKey = "reelsCacheKey";

/// A singleton instance of [CacheManager] for managing cached reels.
///
/// This cache manager is configured with:
/// - **Stale Period**: Items in the cache will be considered stale after 7 days.
/// - **Maximum Number of Cache Objects**: Up to 100 reels can be cached at any time.
/// - **Repository**: Uses a JSON cache info repository with the specified database name.
/// - **File Service**: Utilizes the HTTP file service for fetching files.
final kCacheManager = CacheManager(
  Config(
    kReelCacheKey,
    stalePeriod: const Duration(days: 7), // Maximum cache duration
    maxNrOfCacheObjects: 100, // Maximum reels to cache
    repo: JsonCacheInfoRepository(databaseName: kReelCacheKey),
    fileService: HttpFileService(),
  ),
);
