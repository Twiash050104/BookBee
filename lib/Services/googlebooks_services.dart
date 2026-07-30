import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

import '../models/book.dart';

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
        !title.contains("pedia") &&
        !title.contains("study guide") &&
        !title.contains("summary") &&
        !title.contains("workbook");
  }

  Future<List<Book>> searchBooks(String query) async {
    final apiKey = dotenv.env['GOOGLE_BOOKS_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Google Books API key not found.');
    }

    final url = Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': 'intitle:$query',
      'maxResults': '20',
      'key': apiKey,
    });

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch books.");
    }

    final data = jsonDecode(response.body);

    if (data["items"] == null) {
      return [];
    }

    final books = (data["items"] as List)
        .map((e) => Book.fromJson(e))
        .where((book) => isValidBook(book, query: query))
        .toList();

    return books;
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

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch books.');
    }

    final data = jsonDecode(response.body);

    if (data['items'] == null) {
      return [];
    }

    final books = (data['items'] as List)
        .map((e) => Book.fromJson(e))
        .where(isValidBook)
        .toList();

    return books;
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

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch new releases.');
    }

    final data = jsonDecode(response.body);

    if (data['items'] == null) {
      return [];
    }

    return (data['items'] as List)
        .map((e) => Book.fromJson(e))
        .where(isValidBook)
        .toList();
  }

  Future<List<Book>> getBooksByGenre(String genre) async {
    final uri = Uri.https('www.googleapis.com', '/books/v1/volumes', {
      'q': 'subject:$genre',
      'orderBy': 'relevance',
      'maxResults': '20',
    });

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load books');
    }

    final data = jsonDecode(response.body);

    final books = (data['items'] as List<dynamic>? ?? [])
        .map((item) => Book.fromJson(item))
        .where(isValidBook)
        .toList();

    return books;
  }
}
