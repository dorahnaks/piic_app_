import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color themeBlue = Color(0xFF4DA3FF);
    const Color themeGreen = Color(0xFF8CC63F);
    const Color themeGold = Color(0xFFFDBD00);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        backgroundColor: themeBlue,
        elevation: 0,
        title: const Text(
          "PIIC Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Welcome message
              const Text(
                "Welcome to PIIC",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: themeBlue,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Wealth Creation for Generations",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Quick Actions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),

              const SizedBox(height: 15),

              // Row of dashboard cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCard(
                    title: "My Savings",
                    icon: Icons.account_balance_wallet_rounded,
                    color: themeBlue,
                  ),
                  buildCard(
                    title: "Investments",
                    icon: Icons.home_work_rounded,
                    color: themeGreen,
                  ),
                  buildCard(
                    title: "My Profile",
                    icon: Icons.person_rounded,
                    color: themeGold,
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Additional empty area for future widgets
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: const Text(
                  "More features coming soon...",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard({
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: 105,
      height: 120,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: color),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
