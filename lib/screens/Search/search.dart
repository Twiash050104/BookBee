import 'package:flutter/material.dart';
import 'package:flutter_bookbee/screens/BookDetail/book_details.dart';
import '../../Widgets/stretch_physics.dart';
import '../Search/search_result_screen.dart';
import '';
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
  final String thumbnail;
  final String subtitle;
  final String? isbn;

  const LocalBook({
    required this.title,
    required this.author,
    required this.image,
    required this.thumbnail,
    required this.subtitle,
    required this.isbn,
  });
}

class _SearchScreenState extends State<SearchScreen> {
  final List<LocalBook> books = [
    // LocalBook(
    //   title: "Harry Potter",
    //   author: "J.K. Rowling",
    //   image: "assets/images/harrypotter.jpg",
    //   subtitle:
    //       "A young wizard discovers his magical destiny and faces the dark wizard who killed his parents.",
    // ),
    // LocalBook(
    //   title: "The Hobbit",
    //   author: "J.R.R. Tolkien",
    //   image: "assets/images/thehobbit.jpg",
    //   subtitle: "",
    // ),
    // LocalBook(
    //   title: "Dune",
    //   author: "Frank Herbert",
    //   image: "assets/images/dune.jpg",
    //   subtitle: "",
    // ),
    // LocalBook(
    //   title: "The Alchemist",
    //   author: "Paulo Coelho",
    //   image: "assets/images/thealchemist.jpg",
    //   subtitle: "",
    // ),
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

          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 2),
            child: Align(
              alignment: AlignmentGeometry.topStart,
              child: Text(
                'All Genres',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
