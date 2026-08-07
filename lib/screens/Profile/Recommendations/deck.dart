import 'package:flutter/material.dart';
import 'package:flutter_bookbee/models/book.dart';
import '../Recommendations/card.dart';
import 'package:flutter_bookbee/screens/BookDetail/book_details.dart';

class DeckSlot {
  final double dx;
  final double dy;
  final double scale;
  final double rotation;
  final int order;

  const DeckSlot({
    required this.dx,
    required this.dy,
    required this.scale,
    required this.rotation,
    required this.order,
  });
}

class RecommendationDeck extends StatefulWidget {
  final List<Book> books;

  const RecommendationDeck({super.key, required this.books});

  @override
  State<RecommendationDeck> createState() => _RecommendationDeckState();
}

class _RecommendationDeckState extends State<RecommendationDeck> {
  late List<Book> deck;

  final List<DeckSlot> slots = const [
    // ⭐ Front
    DeckSlot(dx: 0, dy: 0, scale: 1.00, rotation: -.01, order: 8),

    // Left Near
    DeckSlot(dx: -38, dy: 14, scale: .93, rotation: -.07, order: 7),

    // Left Far
    DeckSlot(dx: -88, dy: 40, scale: .84, rotation: -.18, order: 6),

    // Right Near
    DeckSlot(dx: 46, dy: 20, scale: .90, rotation: .06, order: 5),

    // Right Far
    DeckSlot(dx: 78, dy: 34, scale: .81, rotation: .14, order: 4),

    // Left Extreme
    DeckSlot(dx: -132, dy: 66, scale: .72, rotation: -.30, order: 3),

    // Right Extreme
    DeckSlot(dx: 112, dy: 58, scale: .74, rotation: .20, order: 2),

    // Very Back (slightly off-center)
    DeckSlot(dx: 18, dy: 96, scale: .63, rotation: .05, order: 1),
  ];

  @override
  void initState() {
    super.initState();
    deck = List.from(widget.books.take(slots.length));
  }

  @override
  void rotateDeck() {
    setState(() {
      final first = deck.removeAt(0);
      deck.add(first);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.books.isEmpty) {
      return const SizedBox();
    }

    final screenWidth = MediaQuery.of(context).size.width;

    final cardWidth = screenWidth * 0.48;
    final cardHeight = cardWidth * 1.5;

    final visibleBooks = deck.length < slots.length
        ? deck.length
        : slots.length;

    return SizedBox(
      width: screenWidth,
      height: cardHeight + 35,
      child: Center(
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity == null) return;

            if (details.primaryVelocity! < 0) {
              rotateDeck();
            }

            if (details.primaryVelocity! > 0) {
              setState(() {
                final last = deck.removeLast();
                deck.insert(0, last);
              });
            }
          },
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: List.generate(visibleBooks, (index) {
              final slot = slots[index];

              return AnimatedPositioned(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,

                left: (screenWidth - cardWidth) / 2 + slot.dx,
                top: slot.dy,

                child: AnimatedRotation(
                  duration: const Duration(milliseconds: 350),
                  turns: slot.rotation / (2 * 3.1415926535),

                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 350),
                    scale: slot.scale,

                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailsScreen(
                              title: deck[index].title,
                              subtitle: deck[index].description,
                              author: deck[index].author,
                              isbn: deck[index].id,
                              thumbnail: deck[index].thumbnail,
                              genres: deck[index].genres,
                            ),
                          ),
                        );
                      },
                      child: RecommendationCard(
                        book: deck[index],
                        width: cardWidth,
                        height: cardHeight,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
