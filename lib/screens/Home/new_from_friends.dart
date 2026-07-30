import 'package:flutter/material.dart';

class NewFromFriends extends StatelessWidget {
  const NewFromFriends({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            'New From Friends',
            style: TextStyle(
              fontSize: 22,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 350,
          decoration: BoxDecoration(color: Colors.orange),
        ),
        Divider(),
        Container(
          width: double.infinity,
          height: 350,
          decoration: BoxDecoration(color: Colors.blue),
        ),
      ],
    );
  }
}
