import 'package:flutter/material.dart';
import 'package:flutter_bookbee/Widgets/glassback_button.dart';
import 'package:flutter_bookbee/Widgets/stretch_physics.dart';
import 'package:flutter_bookbee/screens/BookDetail/book_palette.dart';
import 'package:flutter_bookbee/screens/BookDetail/genre_chips.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bookbee/models/book.dart';

class BookDetailsScreen extends StatefulWidget {
  final String title;
  final String subtitle;
  final String author;
  final String? isbn;
  final String thumbnail;
  final List<String> genres;

  const BookDetailsScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.isbn,
    required this.thumbnail,
    required this.genres,
  });

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFFFFBEC),
                  const Color(0xFFFFFBEC).withOpacity(.75),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
          ),

          Stack(
            children: [
              PaletteColor(imagePath: widget.thumbnail, isbn: widget.isbn),
              SafeArea(
                top: false,
                child: SingleChildScrollView(
                  physics: const Mycustomphysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .55,
                        child: Center(
                          child: Hero(
                            tag: widget.thumbnail,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 18,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),

                                child: Builder(
                                  builder: (context) {
                                    debugPrint("TITLE: ${widget.title}");
                                    //debugPrint("Cover URL: ${widget.image}");
                                    debugPrint(
                                      "Thumbnail URL: ${widget.thumbnail}",
                                    );
                                    return CachedNetworkImage(
                                      imageUrl: widget.thumbnail,
                                      width:
                                          MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.35,
                                      fit: BoxFit.cover,

                                      placeholder: (context, url) => Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.5,
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.35,
                                        color: Colors.grey.shade300,
                                      ),

                                      errorWidget: (context, url, error) {
                                        return CachedNetworkImage(
                                          imageUrl: widget.thumbnail,
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.5,
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.height *
                                              0.35,
                                          fit: BoxFit.cover,

                                          placeholder: (context, url) =>
                                              Container(
                                                color: Colors.grey.shade300,
                                              ),

                                          errorWidget: (context, url, error) {
                                            return Container(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.5,
                                              height:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.height *
                                                  0.35,
                                              color: Colors.grey.shade300,
                                              child: const Center(
                                                child: Icon(
                                                  Icons.menu_book,
                                                  size: 60,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.55,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(24, 30, 24, 40),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(35),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.title,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style
                                      .copyWith(
                                        fontSize: 17,
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
                                      text: widget.author,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 8),
                              const Text(
                                "...",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),
                              Text(
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                                widget.subtitle,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.7,
                                ),
                              ),

                              const SizedBox(height: 40),
                              GenreChips(genres: widget.genres),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Fixed Back Button
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 2, 10, 8),
                  child: GlassBackButton(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
