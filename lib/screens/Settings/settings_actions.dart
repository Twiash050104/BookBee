import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bookbee/Widgets/frosted_container.dart';
import 'package:flutter_bookbee/screens/Settings/About/about.dart';
import 'package:flutter_bookbee/screens/Settings/Account/account.dart';
import 'package:flutter_bookbee/screens/Settings/Account/account_header.dart';
import 'package:flutter_bookbee/screens/Settings/ChnagePassword/chnage_password.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Settings/Account/account_header.dart';

class SettingsActions extends StatefulWidget {
  const SettingsActions({super.key});

  @override
  State<SettingsActions> createState() => _SettingsActionsState();
}

class _SettingsActionsState extends State<SettingsActions> {
  Widget settingTile({
    required IconData icon,
    required String title,
    Color iconColor = Colors.black87,
    Color textColor = Colors.black87,
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 26),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 17,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }

  Widget settingsCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFAB40).withOpacity(0.18),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.orange.withOpacity(0.15), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(left: 30, bottom: 4, top: 4),
        //   child: Text(
        //     'Profile',
        //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 18, left: 12, right: 12),
          child: Container(
            width: double.infinity,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(32),
            //   color: Color(0xFFFFAB40).withOpacity(0.4),
            // ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Personal",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),

                settingsCard(
                  children: [
                    settingTile(
                      icon: Icons.person_outline,
                      title: "Account",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Account()),
                        );
                      },
                    ),

                    Divider(height: 1, color: Colors.black12),
                    settingTile(
                      icon: Icons.light_mode_outlined,
                      title: "Dynamic Themes",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Dynamic Themes',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                'Dynamic Themes are currently under development. Thank you for your patience!',
                              ),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFE9A34),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    Divider(height: 1, color: Colors.black12),
                    settingTile(
                      icon: Icons.flag_outlined,
                      title: "Reading Goals",
                      onTap: () {},
                    ),
                    Divider(height: 1, color: Colors.black12),
                    settingTile(
                      icon: Icons.interests_outlined,
                      title: "Reading Interests",
                      onTap: () {},
                    ),
                    Divider(height: 1, color: Colors.black12),
                    settingTile(
                      icon: Icons.lock_outline,
                      title: "Change Password",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePassword(),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                // const SizedBox(height: 30),

                // const Text(
                //   "PREFERENCES",
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //     letterSpacing: 1.2,
                //   ),
                // ),
                // const SizedBox(height: 8),

                // settingsCard(
                //   children: [
                //     settingTile(
                //       icon: Icons.notifications_outlined,
                //       title: "Notifications",
                //       onTap: () {},
                //     ),
                //     const Divider(height: 1),
                //     settingTile(
                //       icon: Icons.palette_outlined,
                //       title: "Appearance",
                //       onTap: () {},
                //     ),
                //   ],
                // ),
                const SizedBox(height: 30),

                const Text(
                  "Support",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),

                settingsCard(
                  children: [
                    settingTile(
                      icon: Icons.menu_book_outlined,
                      title: "Request a Book",
                      onTap: () {},
                    ),

                    const Divider(height: 1, color: Colors.black12),
                    settingTile(
                      icon: Icons.policy_outlined,
                      title: "Privacy Policy",
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Colors.black12),
                    settingTile(
                      icon: Icons.bug_report_outlined,
                      title: "Report a Bug",
                      onTap: () {},
                    ),
                    const Divider(height: 1, color: Colors.black12),
                    settingTile(
                      icon: Icons.info_outline,
                      title: "About BookBee",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => About()),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  "Account Actions",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    letterSpacing: 1.2,
                    // color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),

                settingsCard(
                  children: [
                    settingTile(
                      icon: Icons.logout_rounded,
                      title: "Logout",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'LOGOUT!',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                'You will be logged out and will have to login again!',
                              ),
                              actions: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFE9A34),
                                  ),
                                  onPressed: () async {
                                    final googleSignIn = GoogleSignIn();

                                    await googleSignIn.signOut();
                                    await FirebaseAuth.instance.signOut();

                                    if (!context.mounted) return;
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const Divider(height: 1, color: Colors.black12),
                    settingTile(
                      icon: Icons.delete_forever_rounded,
                      title: "Delete Account",
                      iconColor: Colors.red,
                      textColor: Colors.red,
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                "Delete Account?",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                "You're about to permanently delete your BookBee account."
                                " All your books, shelves, reviews, and progress will be lost forever.",
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(
                                            color: Colors.black54,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: FilledButton(
                                        style: FilledButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "DELETE",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
