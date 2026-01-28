import 'package:flutter/material.dart';

class InvestmentsScreen extends StatelessWidget {
  const InvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Investments"),
        backgroundColor: const Color(0xFF8CC63F),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          investmentCard("Plot Package", "50x100ft", "Active"),
          investmentCard("Farmland", "½ Acre", "Completed"),
          investmentCard("Housing", "2 Bedroom House", "Pending"),
        ],
      ),
    );
  }
}

class investmentCard extends StatelessWidget {
  final String title;
  final String size;
  final String status;

  const investmentCard(this.title, this.size, this.status, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: const Icon(Icons.home_work),
        title: Text(title),
        subtitle: Text(size),
        trailing:
            Text(status, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
