import 'package:flutter/material.dart';
import 'package:flutter_bookbee/models/book.dart';
import 'package:flutter_bookbee/services/bookshelf_services.dart';
import 'package:flutter_bookbee/services/googlebooks_services.dart';
import '../Recommendations/deck.dart';

class RecommendationSection extends StatefulWidget {
  const RecommendationSection({super.key});

  @override
  State<RecommendationSection> createState() => _RecommendationSectionState();
}

class _RecommendationSectionState extends State<RecommendationSection> {
  final BookshelfServices _bookshelfServices = BookshelfServices();
  final GoogleBooksService _googleBooksService = GoogleBooksService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _bookshelfServices.getTopGenre(),
      builder: (context, genreSnapshot) {
        if (genreSnapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }

        if (!genreSnapshot.hasData) {
          return const SizedBox();
        }

        final genre = genreSnapshot.data!;

        return FutureBuilder<List<Book>>(
          future: _googleBooksService.getBooksByGenre(genre),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }

            if (snapshot.hasError) {
              return const SizedBox();
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const SizedBox();
            }

            final books = snapshot.data!;
            print("Recommendations: ${books.length}");
            for (final book in books) {
              print(book.title);
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Recommended based on",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    textAlign: TextAlign.justify,
                    genre,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  RecommendationDeck(books: books),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
