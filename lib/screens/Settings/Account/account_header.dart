import 'package:flutter/material.dart';
import 'package:flutter_bookbee/Widgets/glassback_button.dart';
import 'dart:ui';

class AccountHeader extends StatefulWidget {
  const AccountHeader({super.key});

  @override
  State<AccountHeader> createState() => _AccountState();
}

class _AccountState extends State<AccountHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        top: MediaQuery.of(context).padding.top,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [GlassBackButton()],
      ),
    );
  }
}
