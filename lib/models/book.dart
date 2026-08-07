class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String? isbn;
  final List<String> genres;
  final String thumbnail;
  final int pageCount;
  final double rating;

  String get coverUrl {
    if (isbn != null && isbn!.isNotEmpty) {
      return 'https://covers.openlibrary.org/b/isbn/$isbn-L.jpg';
    }

    return thumbnail;
  }

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.isbn,
    required this.genres,
    required this.thumbnail,
    required this.pageCount,
    required this.rating,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'isbn': isbn,
      'genres': genres,
      'thumbnail': thumbnail,
      'pageCount': pageCount,
      'rating': rating,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      description: map['description'] ?? '',
      isbn: map['isbn'],
      genres: List<String>.from(map['genres'] ?? []),
      thumbnail: map['thumbnail'] ?? '',
      pageCount: map['pageCount'] ?? 0,
      rating: (map['rating'] ?? 0).toDouble(),
    );
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    final info = json['volumeInfo'];
    final identifiers = info['industryIdentifiers'] as List?;
    String? isbn;

    if (identifiers != null) {
      for (final item in identifiers) {
        if (item['type'] == 'ISBN_13') {
          isbn = item['identifier'];
          break;
        }
      }

      isbn ??= identifiers.first['identifier'];
    }
    //final List<String> genres;

    return Book(
      isbn: isbn,
      id: json['id'] ?? '',
      title: info['title'] ?? 'Unknown Title',
      author: (info['authors'] != null)
          ? (info['authors'] as List).join(', ')
          : 'Unknown Author',
      description: info['description'] ?? 'No description available.',
      genres: (info['categories'] != null)
          ? List<String>.from(info['categories'])
          : [],
      thumbnail:
          (info['imageLinks']?['extraLarge'] ??
                  info['imageLinks']?['large'] ??
                  info['imageLinks']?['medium'] ??
                  info['imageLinks']?['small'] ??
                  info['imageLinks']?['thumbnail'] ??
                  info['imageLinks']?['smallThumbnail'] ??
                  "https://via.placeholder.com/150x220?text=No+Cover")
              .replaceFirst('http://', 'https://')
              .replaceAll('zoom=1', 'zoom=3'),
      pageCount: info['pageCount'] ?? 0,
      rating: (info['averageRating'] ?? 0).toDouble(),
    );
  }
}
