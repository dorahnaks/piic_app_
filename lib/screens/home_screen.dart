import 'package:flutter/material.dart';
import 'savings_screen.dart';
import 'investments_screen.dart';
import 'profile_screen.dart';
import 'clusters_screen.dart';
import 'savings_progress_screen.dart';
import 'risk_prediction_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Elegant color palette
  static const Color primaryBlue = Color(0xFF4FC3F7);
  static const Color deepBlue = Color(0xFF0288D1);
  static const Color softGray = Color(0xFFF5F7FA);
  static const Color textDark = Color(0xFF2D3748);
  static const Color textLight = Color(0xFF718096);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Clean Header
              _buildHeader(context),

              const SizedBox(height: 24),

              // Balance Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildBalanceCard(),
              ),

              const SizedBox(height: 32),

              // Quick Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildQuickStats(),
              ),

              const SizedBox(height: 36),

              // Services Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Services",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildServicesGrid(context),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Announcement
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildAnnouncement(),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning",
                style: TextStyle(
                  fontSize: 15,
                  color: textLight,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Welcome Back 👋",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: textDark,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: softGray,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(
                    Icons.notifications_none_rounded,
                    color: textDark,
                    size: 24,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEF5350),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [primaryBlue, deepBlue],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Savings",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.groups_rounded, color: Colors.white, size: 14),
                    SizedBox(width: 4),
                    Text(
                      "Cluster A",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "UGX 4,300,000",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildBalanceDetail(
                  icon: Icons.trending_up_rounded,
                  label: "Progress",
                  value: "65%",
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              Expanded(
                child: _buildBalanceDetail(
                  icon: Icons.calendar_today_rounded,
                  label: "This Month",
                  value: "+180K",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceDetail({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.account_balance_wallet_rounded,
            label: "Monthly Target",
            value: "UGX 200K",
            color: const Color(0xFF66BB6A),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.real_estate_agent_rounded,
            label: "Investments",
            value: "3 Active",
            color: const Color(0xFFFF9800),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: softGray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 14),
          Text(
            label,
            style: TextStyle(
              color: textLight,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: textDark,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      {
        'title': 'My Savings',
        'icon': Icons.savings_rounded,
        'color': const Color(0xFF4FC3F7),
        'page': const SavingsScreen(),
      },
      {
        'title': 'Progress',
        'icon': Icons.analytics_rounded,
        'color': const Color(0xFF66BB6A),
        'page': const SavingsProgressScreen(),
      },
      {
        'title': 'Clusters',
        'icon': Icons.groups_rounded,
        'color': const Color(0xFFFF9800),
        'page': const ClustersScreen(),
      },
      {
        'title': 'Invest',
        'icon': Icons.home_work_rounded,
        'color': const Color(0xFF9C27B0),
        'page': const InvestmentsScreen(),
      },
      {
        'title': 'Profile',
        'icon': Icons.person_rounded,
        'color': const Color(0xFF26C6DA),
        'page': const ProfileScreen(),
      },
      {
        'title': 'Risk',
        'icon': Icons.show_chart_rounded,
        'color': const Color(0xFFEF5350),
        'page': const RiskPredictionScreen(),
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.95,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return _buildServiceCard(
          context,
          title: service['title'] as String,
          icon: service['icon'] as IconData,
          color: service['color'] as Color,
          page: service['page'] as Widget,
        );
      },
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncement() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFFE082),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFB300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.campaign_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              "Next land allocation scheduled for November. Keep your savings updated!",
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF5D4037),
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}