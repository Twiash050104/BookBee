import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookbee/models/book.dart';
import '../Recommendations/section.dart';

class RecommendationCard extends StatelessWidget {
  final Book book;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const RecommendationCard({
    super.key,
    required this.book,
    this.onTap,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: book.id,
        child: Container(
          width: width,
          height: height,
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
            child: CachedNetworkImage(
              imageUrl: book.coverUrl,
              fit: BoxFit.cover,

              placeholder: (context, url) =>
                  Container(color: Colors.grey.shade300),

              errorWidget: (context, url, error) {
                return CachedNetworkImage(
                  imageUrl: book.thumbnail,
                  fit: BoxFit.cover,

                  errorWidget: (_, __, ___) => Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.menu_book, size: 50),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
