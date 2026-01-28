import 'package:flutter/material.dart';

class RiskPredictionScreen extends StatelessWidget {
  const RiskPredictionScreen({super.key});

  static const Color themeBlue = Color(0xFF4DA3FF);
  static const Color themeGreen = Color(0xFF8CC63F);
  static const Color themeRed = Color(0xFFE53935);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Risk Prediction"),
        backgroundColor: themeBlue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro
            const Text(
              "Savings Risk Analysis",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "This screen shows a prediction of potential savings risk "
              "based on contribution behavior.",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            // Risk Status Card
            riskStatusCard(),

            const SizedBox(height: 30),

            const Text(
              "Risk Factors Considered",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // Risk factors
            factorTile(
              icon: Icons.schedule,
              title: "Late Contributions",
              subtitle: "Missed or delayed monthly payments",
            ),
            factorTile(
              icon: Icons.trending_down,
              title: "Inconsistent Savings",
              subtitle: "Irregular contribution amounts",
            ),
            factorTile(
              icon: Icons.groups,
              title: "Cluster Performance",
              subtitle: "Overall group savings behavior",
            ),

            const SizedBox(height: 30),

            // Predict Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  // UI only
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Risk prediction will be available in the next version.",
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.analytics),
                label: const Text(
                  "Run Risk Prediction",
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Info Note
            infoNote(),
          ],
        ),
      ),
    );
  }

  // ---------------- RISK STATUS CARD ----------------

  Widget riskStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: themeGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 40,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Low Risk",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Your savings behavior is currently stable. "
                  "Continue contributing regularly.",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- FACTOR TILE ----------------

  Widget factorTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: themeBlue, size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- INFO NOTE ----------------

  Widget infoNote() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: const [
          Icon(Icons.info_outline, color: themeBlue),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "This prediction is for advisory purposes only. "
              "Actual results depend on consistent savings behavior.",
              style: TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
