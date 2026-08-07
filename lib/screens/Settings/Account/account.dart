import 'package:flutter/material.dart';
import 'package:flutter_bookbee/screens/Settings/Account/account_details.dart';
import 'package:flutter_bookbee/screens/Settings/Account/account_header.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                //AccountHeader(),
                Expanded(child: AccountDetailsScreen()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
