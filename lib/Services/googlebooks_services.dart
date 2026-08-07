import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

import '../models/book.dart';

import 'package:flutter_bookbee/Services/cache_services.dart';

class GoogleBooksService {
  bool isValidBook(Book book, {String? query}) {
    final title = book.title.toLowerCase();
    final searchQuery = query?.toLowerCase();

    return (searchQuery == null || title.contains(searchQuery)) &&
        book.description != 'No description available.' &&
        book.thumbnail.isNotEmpty &&
        !book.thumbnail.contains('placeholder') &&
        !title.contains("activity book") &&
        !title.contains("analysis") &&
        !title.contains("box set") &&
        !title.contains("boxed set") &&
        !title.contains("collection") &&
        !title.contains("coloring book") &&
        !title.contains("companion") &&
        !title.contains("complete collection") &&
        !title.contains("description") &&
        !title.contains("design") &&
        !title.contains("facts") &&
        !title.contains("fan") &&
        !title.contains("guide") &&
        !title.contains("movie") &&
        !title.contains("meme") &&
        !title.contains("pedia") &&
        !title.contains("study guide") &&
        !title.contains("summary") &&
        !title.contains("workbook");
  }

  Future<List<Book>> _fetchWithCache({
    required String cacheKey,
    required Uri url,
    String? query,
  }) async {
    final cached = await CacheService.get(cacheKey);

    if (cached != null) {
      print("📦 Loaded from Cache: $cacheKey");

      final books = (cached["items"] as List)
          .map((e) => Book.fromJson(e))
          .where((book) => isValidBook(book, query: query))
          .toList();

      return books;
    }

    print("🌐 Calling Google Books API: $cacheKey");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch books.");
    }

    final data = jsonDecode(response.body);

    await CacheService.save(key: cacheKey, json: data);

    final books = (data["items"] as List? ?? [])
        .map((e) => Book.fromJson(e))
        .where((book) => isValidBook(book, query: query))
        .toList();

    return books;
  }

  Future<List<Book>> searchBooks(String query) async {
    final apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Google Books API key not found.');
    }

    final url = Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': 'intitle:$query',
      'maxResults': '40',
      'key': apiKey,
      'printType': 'books',
    });

    return _fetchWithCache(
      cacheKey: "search_${query.toLowerCase()}",
      url: url,
      query: query,
    );
  }

  Future<List<Book>> getPopularBooks({String genre = 'fiction'}) async {
    final apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Google Books API key not found.');
    }

    final url = Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': 'subject:$genre',
      'orderBy': 'relevance',
      'maxResults': '8',
      'printType': 'books',
      'key': apiKey,
    });

    return _fetchWithCache(cacheKey: "popular_$genre", url: url);
  }

  Future<List<Book>> getNewReleases({String genre = 'fiction'}) async {
    final apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Google Books API key not found.');
    }

    final url = Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': 'subject:$genre',
      'orderBy': 'newest',
      'maxResults': '8',
      'printType': 'books',
      'key': apiKey,
    });

    return _fetchWithCache(cacheKey: "new_$genre", url: url);
  }

  Future<List<Book>> getBooksByGenre(String genre) async {
    final apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Google Books API key not found.');
    }

    final url = Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': 'subject:$genre',
      'orderBy': 'relevance',
      'maxResults': '20',
      'printType': 'books',
      'key': apiKey,
    });

    return _fetchWithCache(cacheKey: "recommendation_$genre", url: url);
  }

  Future<List<Book>> getRecommendationCandidates(String genre) async {
    final apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Google Books API key not found.');
    }

    final url = Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': 'subject:$genre',
      'orderBy': 'relevance',
      'maxResults': '40',
      'printType': 'books',
      'key': apiKey,
    });

    return _fetchWithCache(
      cacheKey: "recommendation_candidates_$genre",
      url: url,
    );
  }
}
