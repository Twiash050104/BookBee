import 'package:flutter/material.dart';
import 'package:flutter_bookbee/screens/BookDetail/book_details.dart';
import '../../Widgets/stretch_physics.dart';
import '../Search/search_result_screen.dart';
// import 'package:flutter_bookbee/models/book.dart';
// import '../BookDetail/genre_chips.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class LocalBook {
  final String title;
  final String author;
  final String image;
  final String subtitle;

  const LocalBook({
    required this.title,
    required this.author,
    required this.image,
    required this.subtitle,
  });
}

class _SearchScreenState extends State<SearchScreen> {
  final List<LocalBook> books = [
    LocalBook(
      title: "Harry Potter",
      author: "J.K. Rowling",
      image: "assets/images/harrypotter.jpg",
      subtitle:
          "A young wizard discovers his magical destiny and faces the dark wizard who killed his parents.",
    ),
    LocalBook(
      title: "The Hobbit",
      author: "J.R.R. Tolkien",
      image: "assets/images/thehobbit.jpg",
      subtitle: "",
    ),
    LocalBook(
      title: "Dune",
      author: "Frank Herbert",
      image: "assets/images/dune.jpg",
      subtitle: "",
    ),
    LocalBook(
      title: "The Alchemist",
      author: "Paulo Coelho",
      image: "assets/images/thealchemist.jpg",
      subtitle: "",
    ),
  ];
  TextEditingController search = TextEditingController();

  Widget _listTileItem(
    String genre,
    IconData icon,
    IconData icons,
    Color iconcolor,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconcolor,
        size: 28,
        shadows: [
          Shadow(
            blurRadius: 12,
            color: Colors.black26,
            offset: Offset(0.5, 1.0),
          ),
        ],
      ),
      trailing: Icon(icons),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => SearchResultScreen(query: genre)),
        );
      },
      title: Text(
        genre,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: MediaQuery.of(context).padding.top + 4,
              bottom: 8,
            ),
            child: TextFormField(
              onFieldSubmitted: (query) {
                if (query.trim().isEmpty) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchResultScreen(query: query),
                  ),
                );
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Search for Books / Author / Friends...',
                suffixIcon: search.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          search.clear();
                          setState(() {});
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const Mycustomphysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 2, top: 6),
                    child: Align(
                      alignment: AlignmentGeometry.topLeft,
                      child: Text(
                        'Your Vibe',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 6),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.orange.shade100,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: books.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: 120,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BookDetailsScreen(
                                                title: books[index].title,
                                                subtitle: books[index].subtitle,
                                                author: books[index].author,
                                                image: books[index].image,
                                                genres: [],
                                              ),
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                      books[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 8,
                  //     right: 8,
                  //     top: 4,
                  //     bottom: 4,
                  //   ),
                  //   child: Divider(),
                  //),
                  //SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, bottom: 2, top: 8),
                    child: Align(
                      alignment: AlignmentGeometry.topLeft,
                      child: Text(
                        'Something New',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.orange.shade100,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: books.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: 120,
                                  child: Image.asset(
                                    books[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      top: 12,
                      bottom: 2,
                    ),
                    child: Align(
                      alignment: AlignmentGeometry.topStart,
                      child: Text(
                        'All Genres',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + 66,
                    ),
                    child: Column(
                      children: [
                        _listTileItem(
                          'Adventure',
                          Icons.explore_rounded,
                          Icons.arrow_forward_ios_rounded,
                          Colors.green.shade600,
                        ),
                        Divider(indent: 16, endIndent: 16),
                        _listTileItem(
                          'Biography',
                          Icons.person_2_rounded,
                          Icons.arrow_forward_ios_rounded,
                          Colors.blue.shade600,
                        ),
                        Divider(indent: 16, endIndent: 16),
                        _listTileItem(
                          'Fantasy',
                          Icons.auto_awesome_rounded,
                          Icons.arrow_forward_ios_rounded,
                          Colors.deepPurple.shade400,
                        ),
                        Divider(indent: 16, endIndent: 16),
                        _listTileItem(
                          'Historical Fiction',
                          Icons.history_edu_rounded,
                          Icons.arrow_forward_ios_rounded,
                          Colors.brown.shade500,
                        ),
                        Divider(indent: 16, endIndent: 16),
                        _listTileItem(
                          'Horror',
                          Icons.dark_mode_rounded,
                          Icons.arrow_forward_ios_rounded,
                          Colors.black87,
                        ),
                        Divider(indent: 16, endIndent: 16),
                        _listTileItem(
                          'Mystery',
                          Icons.manage_search_rounded,
                          Icons.arrow_forward_ios_rounded,
                          Colors.blueGrey.shade600,
                        ),
                        Divider(indent: 16, endIndent: 16),
                        _listTileItem(
                          'Romance',
                          Icons.favorite_rounded,
                          Icons.arrow_forward_ios_rounded,
                          Colors.red.shade400,
                        ),
                        Divider(indent: 16, endIndent: 16),
                        _listTileItem(
                          'Science Fiction',
                          Icons.rocket_launch_rounded,
                          Icons.arrow_forward_ios_rounded,
                          Colors.cyan.shade600,
                        ),
                        Divider(indent: 16, endIndent: 16),
                        _listTileItem(
                          'Thriller',
                          Icons.flash_on_rounded,
                          Icons.arrow_forward_ios_rounded,
                          Colors.deepOrange.shade500,
                        ),
                        Divider(indent: 16, endIndent: 16),
                        _listTileItem(
                          'Young Adult',
                          Icons.groups_2_rounded,
                          Icons.arrow_forward_ios_rounded,
                          Colors.amber.shade500,
                        ),
                        Divider(indent: 16, endIndent: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
