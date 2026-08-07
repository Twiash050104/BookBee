import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bookbee/screens/Settings/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Usercard extends StatefulWidget {
  const Usercard({super.key});
  @override
  State<Usercard> createState() => _UsercardState();
}

class _UsercardState extends State<Usercard> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.orange, Colors.transparent],
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              right: 0,
              left: 0,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      final data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      return Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                        data["bio"] ?? "",
                      );
                    },
                  ),
                ),
              ),
            ),

            Positioned(
              right: 0,
              left: 0,
              bottom: 10,
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.grey.withOpacity(0.2),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                            width: 0.9,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator();
                                  }

                                  final data =
                                      snapshot.data!.data()
                                          as Map<String, dynamic>;

                                  return Text(
                                    data['name'],
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
