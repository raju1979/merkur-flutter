import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user_model.dart';
import 'login_page.dart'; // so we can navigate back to LoginPage
import 'messages.dart';
import 'app_drawer.dart';

class UserDashboardPage extends StatelessWidget {
  const UserDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final fullName =
        '${user.jwtPayload?['firstName'] ?? ''} ${user.jwtPayload?['lastName'] ?? ''}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Welcome $fullName',
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFF5F5F5),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _dashboardTile(context, 'Messages', 'assets/messages.png'),
          _dashboardTile(context, 'QUIZ', 'assets/quiz.jpg'),
          _dashboardTile(context, 'Papers', 'assets/paper.png'),
          _dashboardTile(context, 'PDF', 'assets/pdf.png'),
          _dashboardTile(context, 'Jobs', 'assets/job.png'),
          _dashboardTile(context, 'About', 'assets/about.png'),
          _dashboardTile(context, 'About YO', 'assets/about.png'),
        ],
      ),
    );
  }

  Widget _dashboardTile(BuildContext context, String title, String iconPath) {
    return GestureDetector(
      onTap: () {
        if (title == 'Messages') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MessagesPage()),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 60, fit: BoxFit.contain),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
