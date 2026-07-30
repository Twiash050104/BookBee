import 'package:flutter/material.dart';
import 'package:flutter_bookbee/screens/BookDetail/book_details.dart';
//import 'package:flutter_bookbee/Motion/stretch_physics.dart';

class ShelfCategories extends StatefulWidget {
  //final String image;
  const ShelfCategories({super.key});

  @override
  State<ShelfCategories> createState() => _ShelfCategoriesState();
}

class _ShelfCategoriesState extends State<ShelfCategories> {
  Widget _shelfCard(
    String title,
    String author,
    String subtitle,
    String image,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsScreen(
                title: title,
                author: author,
                image: image,
                subtitle: subtitle,
                genres: [],
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
                  child: Image.asset(
                    image,
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    fit: BoxFit.cover,
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
                        title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2),
                      RichText(
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
                              text: author,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      Expanded(
                        child: Text(
                          subtitle,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            height: 1.4,
                          ),
                        ),
                      ),
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
    return SingleChildScrollView(
      //physics: Mycustomphysics(),
      child: Column(
        children: [
          _shelfCard(
            "Harry Potter",
            "J.K. Rowling",
            "A young wizard discovers his magical destiny and faces the dark wizard who killed his parents.",
            "assets/images/harrypotter.jpg",
          ),

          _shelfCard(
            "The Hobbit",
            "J.R.R. Tolkien",
            "Bilbo Baggins embarks on an unexpected adventure with thirteen dwarves to reclaim their homeland.",
            "assets/images/thehobbit.jpg",
          ),

          _shelfCard(
            "The Alchemist",
            "Paulo Coelho",
            "A shepherd named Santiago travels across the desert in search of his personal legend.",
            "assets/images/thealchemist.jpg",
          ),

          _shelfCard(
            "The Lord of the Rings",
            "J.R.R. Tolkien",
            "Frodo Baggins embarks on a perilous quest to destroy the One Ring and save Middle-earth from the Dark Lord Sauron.",
            "assets/images/lotr.jpg",
          ),

          _shelfCard(
            "The Silent Patient",
            "Alex Michaelides",
            "A renowned painter stops speaking after a shocking act of violence, leaving a psychotherapist determined to uncover the truth.",
            "assets/images/thesilentpatient.jpg",
          ),

          _shelfCard(
            "Dune",
            "Frank Herbert",
            "Paul Atreides journeys to the desert planet Arrakis, where politics, prophecy, and survival shape the fate of the universe.",
            "assets/images/dune.jpg",
          ),
        ],
      ),
    );
  }
}
