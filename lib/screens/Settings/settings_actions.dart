import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bookbee/Widgets/frosted_container.dart';

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
                  "ACCOUNT",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),

                settingsCard(
                  children: [
                    settingTile(
                      icon: Icons.person_outline,
                      title: "Account",
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    settingTile(
                      icon: Icons.edit_outlined,
                      title: "Edit Profile",
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    settingTile(
                      icon: Icons.interests_outlined,
                      title: "Reading Interests",
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    settingTile(
                      icon: Icons.lock_outline,
                      title: "Change Password",
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  "PREFERENCES",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),

                settingsCard(
                  children: [
                    settingTile(
                      icon: Icons.notifications_outlined,
                      title: "Notifications",
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    settingTile(
                      icon: Icons.palette_outlined,
                      title: "Appearance",
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  "SUPPORT",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 8),

                settingsCard(
                  children: [
                    settingTile(
                      icon: Icons.info_outline,
                      title: "About BookBee",
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    settingTile(
                      icon: Icons.feedback_outlined,
                      title: "Send Feedback",
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                const Text(
                  "Don't Leave Us",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),

                settingsCard(
                  children: [
                    settingTile(
                      icon: Icons.logout_rounded,
                      title: "Logout",
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();

                        if (!context.mounted) return;
                        Navigator.pop(context);
                      },
                    ),
                    const Divider(height: 1),
                    settingTile(
                      icon: Icons.delete_forever_rounded,
                      title: "Delete Account",
                      iconColor: Colors.red,
                      textColor: Colors.red,
                      onTap: () {},
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
