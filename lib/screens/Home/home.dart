import 'package:flutter/material.dart';
import 'package:flutter_bookbee/Widgets/stretch_physics.dart';
import 'package:flutter_bookbee/screens/Home/new_from_friends.dart';
import '../Home/home_header.dart';
import '../Home/popular_books.dart';
import 'package:flutter_bookbee/models/book.dart';
import 'package:flutter_bookbee/services/googlebooks_services.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GoogleBooksService service = GoogleBooksService();

  final List<String> genres = [
    'Fantasy',
    'Adventure',
    'Mystery',
    'Fiction',
    'Romance',
    'Horror',
    'Thriller',
    'History',
    'Biography',
    'Young Adult',
  ];

  final Random random = Random();

  late Future<List<Book>> _popularBooks;
  late Future<List<Book>> _newReleases;

  List<String> getRandomGenre(int count) {
    final shuffled = List<String>.from(genres)..shuffle(random);
    return shuffled.take(count).toList();
  }

  Future<void> _refreshHome() async {
    setState(() {
      final randomGenres = getRandomGenre(2);

      _popularBooks = service.getPopularBooks(genre: randomGenres[0]);

      _newReleases = service.getNewReleases(genre: randomGenres[1]);
    });

    await Future.wait([_popularBooks, _newReleases]);
  }

  @override
  void initState() {
    super.initState();
    final randomGenres = getRandomGenre(2);

    _popularBooks = service.getPopularBooks(genre: randomGenres[0]);

    _newReleases = service.getNewReleases(genre: randomGenres[1]);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: HomeHeader(),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshHome,
            child: SingleChildScrollView(
              physics: Mycustomphysics(),
              child: Column(
                children: [
                  FutureBuilder<List<Book>>(
                    future: _popularBooks,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center();
                      }

                      if (snapshot.hasError) {
                        return const Center(child: Text('Failed to load'));
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No books found'));
                      }

                      return TopBooks(books: snapshot.data!);
                    },
                  ),
                  NewFromFriends(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
