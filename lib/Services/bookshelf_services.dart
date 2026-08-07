import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bookbee/utils/genre_mapper.dart';
import '../models/book.dart';

class BookshelfServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _shelf {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return _firestore.collection('users').doc(uid).collection('shelf');
  }

  int getStatusWeight(String status) {
    switch (status) {
      case "Completed":
        return 3;

      case "Reading":
        return 2;

      case "To Read":
        return 1;

      case "Dropped":
        return 0;

      default:
        return 1;
    }
  }

  Future<void> addBook(Book book, String status) async {
    await _shelf.doc(book.id).set({
      ...book.toMap(),
      'status': status,
      'savedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> updateBookStatus(String bookId, String status) async {
    await _shelf.doc(bookId).update({'status': status});
  }

  Future<void> removeBook(String bookId) async {
    await _shelf.doc(bookId).delete();
  }

  Future<bool> isBookSaved(String bookId) async {
    final doc = await _shelf.doc(bookId).get();

    return doc.exists;
  }

  Stream<List<Book>> getBooks(String status) {
    return _shelf
        .where('status', isEqualTo: status)
        .orderBy('savedAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Book.fromMap(doc.data())).toList();
        });
  }

  Stream<Map<String, int>> getShelfStats() {
    return _shelf.snapshots().map((snapshot) {
      final stats = {"Reading": 0, "Completed": 0, "To Read": 0, "Dropped": 0};

      for (final doc in snapshot.docs) {
        final status = doc["status"] as String?;

        if (status != null && stats.containsKey(status)) {
          stats[status] = stats[status]! + 1;
        }
      }

      return stats;
    });
  }

  //Stream<String>? getTopGenre() {}

  Stream<String> getTopGenre() {
    return _shelf.snapshots().map((snapshot) {
      final Map<String, int> genreCount = {};

      for (final doc in snapshot.docs) {
        final book = Book.fromMap(doc.data());

        final status = doc['status'] as String? ?? "";
        final weight = getStatusWeight(status);

        for (final genre in book.genres) {
          final normalized = normalizeGenre(genre);

          if (normalized == "Fiction") continue;

          genreCount[normalized] = (genreCount[normalized] ?? 0) + weight;
        }
      }

      if (genreCount.isEmpty) {
        return "Fiction";
      }

      final topGenre = genreCount.entries.reduce(
        (a, b) => a.value > b.value ? a : b,
      );

      return topGenre.key;
    });
  }
}
