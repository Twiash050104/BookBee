class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final List<String> genres;
  final String thumbnail;
  final int pageCount;
  final double rating;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.genres,
    required this.thumbnail,
    required this.pageCount,
    required this.rating,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final info = json['volumeInfo'];
    //final List<String> genres;

    return Book(
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
          info['imageLinks']?['thumbnail'] ??
          "https://via.placeholder.com/150x220?text=No+Cover",
      pageCount: info['pageCount'] ?? 0,
      rating: (info['averageRating'] ?? 0).toDouble(),
    );
  }
}
