import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'models/user_model.dart';
import 'login_page.dart';
import 'messages.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  // A list of attractive colors for the icons
  static const List<Color> _iconColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];

  // A helper to get a random color from the list
  Color _getRandomColor() {
    return _iconColors[Random().nextInt(_iconColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final fullName =
        '${user.jwtPayload?['firstName'] ?? ''} ${user.jwtPayload?['lastName'] ?? ''}';

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(fullName),
            accountEmail: Text(user.email ?? ''),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.deepPurple),
            ),
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _createDrawerItem(
                  icon: Icons.message,
                  text: 'Messages',
                  color: _getRandomColor(),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MessagesPage(),
                      ),
                    );
                  },
                ),
                _createDrawerItem(
                    icon: Icons.quiz,
                    text: 'QUIZ',
                    color: _getRandomColor(),
                    onTap: () {}),
                _createDrawerItem(
                    icon: Icons.description,
                    text: 'Papers',
                    color: _getRandomColor(),
                    onTap: () {}),
                _createDrawerItem(
                    icon: Icons.picture_as_pdf,
                    text: 'PDF',
                    color: _getRandomColor(),
                    onTap: () {}),
                _createDrawerItem(
                    icon: Icons.work,
                    text: 'Jobs',
                    color: _getRandomColor(),
                    onTap: () {}),
                _createDrawerItem(
                    icon: Icons.info,
                    text: 'About',
                    color: _getRandomColor(),
                    onTap: () {}),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              // Clear state
              Provider.of<UserModel>(context, listen: false).clear();

              // Clear SharedPreferences
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('accessToken');
              await prefs.remove('userData');

              // Navigate to login screen
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required Color color,
      required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text),
      onTap: onTap,
    );
  }
}
