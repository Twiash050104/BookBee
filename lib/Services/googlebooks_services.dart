import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;

import '../models/book.dart';

class GoogleBooksService {
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

    return (data["items"] as List).map((e) => Book.fromJson(e)).toList();
  }
}
