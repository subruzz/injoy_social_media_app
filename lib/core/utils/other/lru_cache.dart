import 'dart:collection';

/// A class that implements a Least Recently Used (LRU) Cache.
///
/// This cache stores key-value pairs and automatically removes the least recently used
/// item when the cache reaches its capacity. It is useful for caching data where
/// access frequency is important.
class LRUCache<K, V> {
  // The maximum capacity of the cache.
  final int _capacity;

  // A LinkedHashMap to maintain the order of keys based on usage.
  final LinkedHashMap<K, V> _cache = LinkedHashMap();

  /// Creates an instance of [LRUCache] with the specified [capacity].
  LRUCache(this._capacity);

  /// Retrieves the value associated with the given [key].
  ///
  /// If the key does not exist, it returns `null`.
  /// If the key is found, it moves the key to the end of the cache to mark it as recently used.
  ///
  /// Returns:
  /// A value of type [V]? associated with the [key], or `null` if the key is not present.
  V? get(K key) {
    if (!_cache.containsKey(key)) return null;

    // Move the accessed item to the end to show that it was recently used
    var value = _cache.remove(key);
    if (value != null) {
      _cache[key] = value;
    }
    return value;
  }

  /// Adds a key-value pair to the cache.
  ///
  /// If the cache exceeds its capacity, the least recently used item will be removed.
  void set(K key, V value) {
    if (_cache.length >= _capacity) {
      // Remove the first key (least recently used)
      _cache.remove(_cache.keys.first);
    }
    _cache[key] = value;
  }

  /// Clears all entries in the cache.
  void clear() {
    _cache.clear();
  }
}

/// Note: This LRUCache class is not currently used in the application.
