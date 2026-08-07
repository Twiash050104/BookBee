import 'package:flutter/material.dart';
import 'package:flutter_bookbee/Widgets/stretch_physics.dart';
import 'package:flutter_bookbee/screens/BookDetail/book_details.dart';
import 'package:flutter_bookbee/models/book.dart';
import 'package:flutter_bookbee/services/bookshelf_services.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShelfCategories extends StatefulWidget {
  final String status;
  const ShelfCategories({super.key, required this.status});

  @override
  State<ShelfCategories> createState() => _ShelfCategoriesState();
}

class _ShelfCategoriesState extends State<ShelfCategories> {
  final BookshelfServices _bookshelfServices = BookshelfServices();

  Widget _shelfCard(Book book) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsScreen(
                title: book.title,
                author: book.author,
                //image: book.coverUrl,
                isbn: book.isbn,
                subtitle: book.description,
                thumbnail: book.thumbnail,
                genres: book.genres,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                color: Colors.black26,
                blurRadius: 4,
              ),
            ],
            color: Color(0xFFFFFCF1),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Book Cover
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 90,
                  height: 140,
                  color: Colors.grey.shade300,
                  child: CachedNetworkImage(
                    imageUrl: book.coverUrl,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,

                    placeholder: (context, url) =>
                        Container(color: Colors.grey.shade500),

                    errorWidget: (context, url, error) {
                      return CachedNetworkImage(
                        imageUrl: book.thumbnail,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,

                        placeholder: (context, url) =>
                            Container(color: Colors.grey.shade500),

                        errorWidget: (context, url, error) {
                          return Container(
                            color: Colors.grey.shade300,
                            child: const Center(
                              child: Icon(Icons.menu_book, size: 40),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: SizedBox(
                  height: 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        book.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      //SizedBox(height: 8),
                      RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                          children: [
                            const TextSpan(
                              text: 'by ',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            TextSpan(
                              text: book.author,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Expanded(
                      //   child: Text(
                      //     book.description,
                      //     maxLines: 3,
                      //     overflow: TextOverflow.ellipsis,
                      //     style: TextStyle(
                      //       color: Colors.grey.shade700,
                      //       height: 1.4,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Book>>(
      stream: _bookshelfServices.getBooks(widget.status),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (!snapshot.hasData) {
          return const Center(child: Text("No data"));
        }

        print(snapshot.connectionState);

        final books = snapshot.data!;

        if (books.isEmpty) {
          return const Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [Text("No books yet!", style: TextStyle(fontSize: 18))],
          );
        }

        return ListView.builder(
          physics: Mycustomphysics(),
          padding: const EdgeInsets.only(bottom: 66),
          itemCount: books.length,
          itemBuilder: (context, index) {
            return _shelfCard(books[index]);
          },
        );
      },
    );
  }
}
