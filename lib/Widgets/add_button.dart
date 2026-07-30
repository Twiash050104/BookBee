import 'package:flutter/material.dart';

class AddBookButton extends StatelessWidget {
  final ValueChanged<String> onSelected;

  const AddBookButton({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: PopupMenuButton<String>(
        color: Theme.of(context).scaffoldBackgroundColor,
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onSelected: onSelected,
        itemBuilder: (context) => const [
          PopupMenuItem(
            value: "Reading",
            child: Text("📖  Reading", style: TextStyle(fontSize: 16)),
          ),
          PopupMenuItem(
            value: "Completed",
            child: Text("✅  Completed", style: TextStyle(fontSize: 16)),
          ),
          PopupMenuItem(
            value: "To Read",
            child: Text("📚  To Read", style: TextStyle(fontSize: 16)),
          ),
          PopupMenuItem(
            value: "Dropped",
            child: Text("❌  Dropped", style: TextStyle(fontSize: 16)),
          ),
        ],
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.black),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.add, size: 20, color: Colors.black87),
              SizedBox(width: 6),
              Text(
                "Add",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
