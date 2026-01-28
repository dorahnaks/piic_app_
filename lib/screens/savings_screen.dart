import 'package:flutter/material.dart';

class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Savings"),
        backgroundColor: const Color(0xFF4DA3FF),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          savingsTile("Total Saved", "UGX 4,300,000"),
          savingsTile("Monthly Contribution", "UGX 150,000"),
          savingsTile("Saving Period", "24 Months"),
          savingsTile("Cluster", "Plot Package - Cluster A"),
        ],
      ),
    );
  }
}

class savingsTile extends StatelessWidget {
  final String title;
  final String value;

  const savingsTile(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        title: Text(title),
        trailing:
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
