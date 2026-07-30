import 'package:flutter/material.dart';

class SettingsActions extends StatefulWidget {
  const SettingsActions({super.key});

  @override
  State<SettingsActions> createState() => _SettingsActionsState();
}

class _SettingsActionsState extends State<SettingsActions> {
  Widget _settingsItem(String name, Icon icon) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        minTileHeight: 20,

        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        iconColor: Theme.of(context).scaffoldBackgroundColor,
        collapsedIconColor: Colors.black87,
        textColor: Theme.of(context).scaffoldBackgroundColor,
        collapsedTextColor: Colors.black87,
        splashColor: Colors.transparent,
        onExpansionChanged: (value) {},
        title: Text(name, style: TextStyle(fontSize: 20)),
        leading: icon,
        trailing: const Icon(Icons.keyboard_arrow_down_rounded, size: 28),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, bottom: 4, top: 4),
          child: Text(
            'Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Color(0xFFFFAB40).withOpacity(0.4),
            ),
            child: Column(
              children: [
                _settingsItem('Account', Icon(Icons.person_2)),
                Divider(color: Theme.of(context).scaffoldBackgroundColor),
                _settingsItem('Interests', Icon(Icons.interests_rounded)),
                Divider(color: Theme.of(context).scaffoldBackgroundColor),
                _settingsItem(
                  'Notifications',
                  Icon(Icons.notifications_rounded),
                ),
                Divider(color: Theme.of(context).scaffoldBackgroundColor),
                _settingsItem('Change Password', Icon(Icons.password_rounded)),
                Divider(color: Theme.of(context).scaffoldBackgroundColor),
                _settingsItem('Logout', Icon(Icons.logout_rounded)),
                Divider(color: Theme.of(context).scaffoldBackgroundColor),
                _settingsItem(
                  'Delete Account',
                  Icon(Icons.delete_forever_rounded),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(left: 30, bottom: 4),
          child: Text(
            'Support',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        //SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Color(0xFFFFAB40).withOpacity(0.4),
            ),
            child: Column(
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      bottom: 12,
                      left: 12,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(width: 12),
                        Text('About BookBee', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
                Divider(color: Theme.of(context).scaffoldBackgroundColor),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.feedback_rounded),
                        SizedBox(width: 12),
                        Text('Send Feedback', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
                Divider(color: Theme.of(context).scaffoldBackgroundColor),
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 12),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.bug_report_rounded),
                        SizedBox(width: 12),
                        Text('Report Bug', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
