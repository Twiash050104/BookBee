import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  static const String _boxName = "book_cache";

  static Future<Box> _box() async {
    return await Hive.openBox(_boxName);
  }

  static Future<void> save({
    required String key,
    required Map<String, dynamic> json,
  }) async {
    final box = await _box();

    await box.put(key, {
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "data": jsonEncode(json),
    });
  }

  static Future<Map<String, dynamic>?> get(String key) async {
    final box = await _box();

    final cached = box.get(key);

    if (cached == null) {
      return null;
    }

    return jsonDecode(cached["data"]);
  }

  static Future<int?> getTimestamp(String key) async {
    final box = await _box();

    final cached = box.get(key);

    if (cached == null) {
      return null;
    }

    return cached["timestamp"];
  }

  static Future<void> remove(String key) async {
    final box = await _box();

    await box.delete(key);
  }

  static Future<void> clear() async {
    final box = await _box();

    await box.clear();
  }
}
