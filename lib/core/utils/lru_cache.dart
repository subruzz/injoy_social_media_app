import 'dart:collection';

class LRUCache<K, V> {
  //capacity of cache
  final int _capacity;
  //linkedhashmap for ordering
  final LinkedHashMap<K, V> _cache = LinkedHashMap();

  LRUCache(this._capacity);

  V? get(K key) {
    if (!_cache.containsKey(key)) return null;

    // Move the accessed item to the end to show that it was recently used
    var value = _cache.remove(key);
    if (value != null) {
      _cache[key] = value;
    }
    return value;
  }

  void set(K key, V value) {
    if (_cache.length >= _capacity) {
      // Remove the first key (least recently used)
      _cache.remove(_cache.keys.first);
    }
    _cache[key] = value;
  }

  void clear() {
    _cache.clear();
  }
}
