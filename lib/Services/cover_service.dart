import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

class CoverService {
  final Box _coverCache = Hive.box('coverCache');

  Future<bool> hasOpenLibraryCover(String? isbn) async {
    if (isbn == null || isbn.isEmpty) {
      return false;
    }

    if (_coverCache.containsKey(isbn)) {
      return _coverCache.get(isbn);
    }

    final cover =
        "https://covers.openlibrary.org/b/isbn/$isbn-L.jpg?default=false";

    try {
      final response = await http.head(Uri.parse(cover));

      final exists = response.statusCode == 200;

      await _coverCache.put(isbn, exists);

      return exists;
    } catch (_) {
      await _coverCache.put(isbn, false);
      return false;
    }
  }

  Future<String> getBestCover({
    required String? isbn,
    required String thumbnail,
  }) async {
    final hasCover = await hasOpenLibraryCover(isbn);

    if (hasCover) {
      return "https://covers.openlibrary.org/b/isbn/$isbn-L.jpg";
    }

    return thumbnail;
  }
}
