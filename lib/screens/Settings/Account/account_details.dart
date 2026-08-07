import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter_bookbee/Widgets/glassback_button.dart';

class AccountDetailsScreen extends StatefulWidget {
  const AccountDetailsScreen({super.key});

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();

  static Widget _infoTile(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController bio = TextEditingController();

  bool isEditing = false;
  bool isInitialized = false;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser!;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(authUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        if (!isInitialized) {
          name.text = data["name"] ?? "";
          bio.text = data["bio"] ?? "";
          isInitialized = true;
        }

        final provider = authUser.providerData.first.providerId == "google.com"
            ? "Google"
            : "Email & Password";

        Future<void> saveProfile() async {
          if (name.text.trim().isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please enter your name.")),
            );
            return;
          }
          setState(() {
            isSaving = true;
          });

          try {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(authUser.uid)
                .update({'name': name.text.trim(), 'bio': bio.text.trim()});

            await authUser.updateDisplayName(name.text.trim());

            setState(() {
              isEditing = false;
              isSaving = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile updated successfully.")),
            );
          } catch (e) {
            setState(() {
              isSaving = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to update profile: $e")),
            );
          }
        }

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GlassBackButton(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.09),
                            width: 0.9,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              spreadRadius: 0.3,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            isEditing
                                ? Icons.close_rounded
                                : Icons.edit_rounded,
                            color: Colors.black87,
                            size: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isEditing) {
                                name.text = data["name"] ?? "";
                                bio.text = data["bio"] ?? "";
                              }

                              isEditing = !isEditing;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    Center(
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFFFAB40).withOpacity(.18),
                          image: authUser.photoURL != null
                              ? DecorationImage(
                                  image: NetworkImage(authUser.photoURL!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: authUser.photoURL == null
                            ? const Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.black54,
                              )
                            : null,
                      ),
                    ),

                    const SizedBox(height: 40),

                    TextFormField(
                      controller: name,
                      readOnly: !isEditing,
                      decoration: InputDecoration(
                        labelText: "Your Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.orange.shade300),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.orange.shade300),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Colors.orange.shade300,
                            width: 1,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      initialValue: data["email"] ?? "",
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Email address",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.orange.shade300),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.orange.shade300),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Colors.orange.shade300,
                            width: 1,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: bio,
                      readOnly: !isEditing,
                      maxLength: 180,
                      decoration: InputDecoration(
                        hintText: 'Tell readers something about you...',
                        labelText: "About You",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.orange.shade300),
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.orange.shade300),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            color: Colors.orange.shade300,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    if (isEditing) ...[
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Color(0xFFFE9A34),
                          foregroundColor: Theme.of(
                            context,
                          ).scaffoldBackgroundColor,
                          fixedSize: Size(
                            MediaQuery.of(context).size.width * 0.5,
                            50,
                          ),
                        ),
                        onPressed: isSaving ? null : saveProfile,

                        child: Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
