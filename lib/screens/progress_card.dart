import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final String clusterName;
  final double amountSaved;
  final double targetAmount;

  const ProgressCard({
    super.key,
    required this.clusterName,
    required this.amountSaved,
    required this.targetAmount,
  });

  @override
  Widget build(BuildContext context) {
    double progress = amountSaved / targetAmount;
    int percentage = (progress * 100).toInt();

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cluster name
            Text(
              clusterName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            // Progress bar
            LinearProgressIndicator(
              value: progress > 1 ? 1 : progress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade300,
              color: progress >= 1
                  ? Colors.green
                  : const Color(0xFF4DA3FF),
            ),

            const SizedBox(height: 8),

            // Amounts
            Text(
              "Saved: UGX ${amountSaved.toStringAsFixed(0)} "
              "of UGX ${targetAmount.toStringAsFixed(0)} ($percentage%)",
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
