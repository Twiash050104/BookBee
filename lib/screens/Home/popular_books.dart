import 'package:flutter/material.dart';
import 'package:flutter_bookbee/Widgets/book_card.dart';
import 'package:flutter_bookbee/screens/BookDetail/book_details.dart';
import 'package:flutter_bookbee/models/book.dart';

class TopBooks extends StatelessWidget {
  final List<Book> books;
  const TopBooks({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Text(
            'All-Time Favorites',
            style: TextStyle(
              fontSize: 22,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 235,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: books.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final book = books[index];

              return BookCard(
                title: book.title,
                coverUrl: book.thumbnail,
                onTap: () {
                  Navigator.push(
                    context,
                    (MaterialPageRoute(
                      builder: (context) => BookDetailsScreen(
                        title: book.title,
                        subtitle: book.description,
                        author: book.author,
                        image: book.thumbnail,
                        genres: book.genres,
                      ),
                    )),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
