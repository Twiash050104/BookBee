import 'package:flutter/material.dart';

// void main() {
//   runApp(TopBooks());
// }

class TopBooks extends StatelessWidget {
  const TopBooks({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Text(
            '📖 Popular Books',
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
          decoration: BoxDecoration(color: Colors.yellow),
        ),
      ],
    );
  }
}
