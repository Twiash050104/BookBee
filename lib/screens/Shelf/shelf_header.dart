import 'package:flutter/material.dart';

class ShelfChips extends StatefulWidget {
  const ShelfChips({super.key});

  @override
  State<ShelfChips> createState() => _ProfileChipsState();
}

class _ProfileChipsState extends State<ShelfChips> {
  int selectedindex = 0;
  //bool onSelected = false;
  Widget profilechips(
    String name,
    //Color textcolor,
    int index,
    //Color fillcolor,
  ) {
    return ChoiceChip(
      selectedColor: Color(0xFFFE9A34),
      showCheckmark: false,
      avatar: selectedindex == index
          ? Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                shape: BoxShape.circle,
              ),
            )
          : null,
      selected: selectedindex == index,
      onSelected: (_) {
        setState(() {
          selectedindex = index;
        });
      },
      label: Text(
        name,
        style: TextStyle(
          fontWeight: selectedindex == index
              ? FontWeight.w800
              : FontWeight.normal,
          color: Colors.black,
          //This will break on devices with small screen chnage this in near future
          fontSize: 14,
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 28, color: Colors.black),
              children: [
                //add username value here
                TextSpan(
                  text:
                      'username'
                      "'"
                      's',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: ' Shelf'),
              ],
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              profilechips('Reading', 0),
              profilechips('Completed', 1),
              profilechips('To Read', 2),
              profilechips('Dropped', 3),
            ],
          ),
        ],
      ),
    );
  }
}
