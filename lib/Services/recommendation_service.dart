import 'package:flutter_bookbee/Services/googlebooks_services.dart';
import 'package:flutter_bookbee/Services/cover_service.dart';
import 'package:flutter_bookbee/models/book.dart';

class RecommendationService {
  final GoogleBooksService _googleBooksService = GoogleBooksService();
  final CoverService _coverService = CoverService();

  Future<List<Book>> getRecommendations(String genre) async {
    final books = await _googleBooksService.getRecommendationCandidates(genre);
    final cacheKey =
        "recommendation_${genre.toLowerCase().replaceAll(' ', '_')}";

    final List<Book> highQuality = [];
    final List<Book> fallback = [];

    return books;
  }
}
