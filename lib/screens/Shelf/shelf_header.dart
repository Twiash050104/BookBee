import 'package:flutter/material.dart';
import 'package:flutter_bookbee/models/user_model.dart';
import 'package:flutter_bookbee/Services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShelfChips extends StatelessWidget {
  final String selectedStatus;
  final ValueChanged<String> onStatusChanged;

  const ShelfChips({
    super.key,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  Widget profilechips(BuildContext context, String name) {
    return ChoiceChip(
      selectedColor: const Color(0xFFFE9A34),
      showCheckmark: false,
      avatar: selectedStatus == name
          ? Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle,
              ),
            )
          : null,
      selected: selectedStatus == name,
      onSelected: (_) {
        onStatusChanged(name);
      },
      label: Text(
        name,
        style: TextStyle(
          fontWeight: selectedStatus == name
              ? FontWeight.w800
              : FontWeight.normal,
          color: Colors.black,
          fontSize: 14,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              final data = snapshot.data!.data() as Map<String, dynamic>;

              final fullName = data['name'] ?? "";
              final firstName = fullName.toString().split(' ').first;

              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: firstName,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          fontSize: 26,
                        ),
                      ),
                      const TextSpan(
                        text: "'s Shelf",
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                          fontSize: 26,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              profilechips(context, 'Reading'),
              profilechips(context, 'Completed'),
              profilechips(context, 'To Read'),
              profilechips(context, 'Dropped'),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
