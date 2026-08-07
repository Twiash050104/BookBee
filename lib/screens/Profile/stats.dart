import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bookbee/Services/bookshelf_services.dart';

class ProfileStats extends StatefulWidget {
  //final ValueChanged<String> onStatTap;
  const ProfileStats({super.key});

  @override
  State<ProfileStats> createState() => _ProfileStatsState();
}

class _ProfileStatsState extends State<ProfileStats> {
  final BookshelfServices _bookshelfServices = BookshelfServices();

  Widget statItem(String title, int count) {
    return Expanded(
      child: InkWell(
        onTap: () {
          //widget.onStatTap(title);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$count",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bookshelfServices.getShelfStats(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final stats = snapshot.data!;
        return IntrinsicHeight(
          child: Row(
            children: [
              statItem("Reading", stats["Reading"]!),
              const VerticalDivider(thickness: 1, color: Colors.grey),
              statItem("Completed", stats["Completed"]!),
              const VerticalDivider(thickness: 1, color: Colors.grey),
              statItem("To Read", stats["To Read"]!),
              const VerticalDivider(thickness: 1, color: Colors.grey),
              statItem("Dropped", stats["Dropped"]!),
            ],
          ),
        );
      },
    );
  }
}
