import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: const Color(0xFFFDBD00),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            CircleAvatar(radius: 45, child: Icon(Icons.person, size: 40)),
            SizedBox(height: 15),
            Text("Dorothy N.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Divider(height: 30),
            ListTile(leading: Icon(Icons.group), title: Text("Cluster A")),
            ListTile(
                leading: Icon(Icons.account_balance),
                title: Text("Plot Package")),
            ListTile(leading: Icon(Icons.logout), title: Text("Logout")),
          ],
        ),
      ),
    );
  }
}
