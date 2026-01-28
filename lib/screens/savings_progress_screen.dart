import 'package:flutter/material.dart';
import './progress_card.dart';

class SavingsProgressScreen extends StatelessWidget {
  const SavingsProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Savings Progress"),
        backgroundColor: const Color(0xFF4DA3FF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            ProgressCard(
              clusterName: "Cluster A – Plot Package",
              amountSaved: 2800000,
              targetAmount: 4300000,
            ),
            ProgressCard(
              clusterName: "Cluster B – Farmland Package",
              amountSaved: 5500000,
              targetAmount: 5500000,
            ),
            ProgressCard(
              clusterName: "Cluster C – Housing Package",
              amountSaved: 72000000,
              targetAmount: 90450000,
            ),
          ],
        ),
      ),
    );
  }
}
