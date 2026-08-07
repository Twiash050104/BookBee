import 'package:flutter/material.dart';
import 'package:flutter_bookbee/services/bookshelf_services.dart';
import 'package:flutter_bookbee/utils/reading_personality.dart';

class Personality extends StatelessWidget {
  Personality({super.key});

  final BookshelfServices _bookshelfServices = BookshelfServices();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _bookshelfServices.getTopGenre(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        final genre = snapshot.data!;
        final personality = getReadingPersonality(genre);

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.orange.shade500,
                ),
              ),

              Positioned(
                top: -35,
                right: -25,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(.22),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Positioned(
                bottom: -30,
                left: -30,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(.30),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 22,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Your Reading Personality",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 14),

                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        personality,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      "$genre stories dominate your bookshelf.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.45,
                        fontStyle: FontStyle.italic,
                        color: Colors.brown.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
