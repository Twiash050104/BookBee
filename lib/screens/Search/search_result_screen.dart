import 'package:flutter/material.dart';
import 'package:flutter_bookbee/Widgets/add_button.dart';
import 'package:flutter_bookbee/models/book.dart';
import 'package:flutter_bookbee/services/googlebooks_services.dart';
import 'package:flutter_bookbee/screens/BookDetail/book_details.dart';
import 'dart:ui';

class SearchResultScreen extends StatefulWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});
  @override
  State<SearchResultScreen> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResultScreen> {
  Future<void> searchBooks(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        books = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      books = await _service.searchBooks(query);

      books = books.where((book) {
        final title = book.title.toLowerCase();

        return title.contains(query.toLowerCase()) &&
            book.description != 'No description available.' &&
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
      }).toList();
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  final GoogleBooksService _service = GoogleBooksService();

  late TextEditingController searchController;

  List<Book> books = [];

  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    searchController = TextEditingController(text: widget.query);

    searchBooks(widget.query);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   title: TextFormField(
      //     controller: searchController,
      //     onFieldSubmitted: searchBooks,
      //     decoration: const InputDecoration(
      //       hintText: "Search books...",
      //       border: InputBorder.none,
      //       prefixIcon: Icon(Icons.search_rounded),
      //     ),
      //   ),
      // ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 8),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                            width: 0.9,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              spreadRadius: 0.3,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black87,
                            size: 20,
                          ),
                          onPressed: () => Navigator.popUntil(
                            context,
                            (route) => route.isFirst,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      onFieldSubmitted: searchBooks,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: "Search books...",
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  searchController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                        //suffixIcon: const Icon(Icons.search_rounded),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Builder(
                builder: (context) {
                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFE9A34),
                      ),
                    );
                  }

                  if (books.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off_rounded, size: 50),
                          Text(
                            "We couldn't find a match...",
                            style: TextStyle(fontSize: 22),
                          ),
                        ],
                      ),
                    );
                  }
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${books.length} Results",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );

                  return ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(22),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BookDetailsScreen(
                                  title: book.title,
                                  subtitle: book.description,
                                  author: book.author,
                                  image: book.thumbnail,
                                  genres: book.genres,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFCF1),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(1, 1),
                                  color: Colors.black26,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      width: 80,
                                      height: 140,
                                      color: Colors.grey.shade300,
                                      child: Image.network(
                                        book.thumbnail,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.menu_book,
                                                size: 40,
                                              );
                                            },
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 18),

                                  Expanded(
                                    child: SizedBox(
                                      //height: 190,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            book.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),

                                          const SizedBox(height: 2),

                                          RichText(
                                            text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(
                                                    context,
                                                  ).style.copyWith(
                                                    fontSize: 16,
                                                    color: Colors.grey.shade700,
                                                  ),
                                              children: [
                                                const TextSpan(
                                                  text: "by ",
                                                  style: TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: book.author,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FontStyle.italic,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          AddBookButton(
                                            onSelected: (value) {
                                              debugPrint(value);
                                            },
                                          ),
                                          //const SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
