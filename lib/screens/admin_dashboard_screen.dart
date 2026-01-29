import 'package:flutter/material.dart';

/// PIIC ClusterSave - Admin Dashboard Screen
/// 
/// Elegant admin dashboard matching PIIC branding
/// Features: Real-time statistics, member management, cluster overview
/// Design: Clean, modern, with signature blue gradient theme

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // PIIC Brand Colors - matching home screen
  static const Color primaryBlue = Color(0xFF4FC3F7);
  static const Color deepBlue = Color(0xFF0288D1);
  static const Color softGray = Color(0xFFF5F7FA);
  static const Color textDark = Color(0xFF2D3748);
  static const Color textLight = Color(0xFF718096);
  static const Color successGreen = Color(0xFF66BB6A);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color dangerRed = Color(0xFFEF5350);

  // ==================== MOCK DATA ====================
  
  /// Mock list of all platform members with their contribution and risk data
  final List<Map<String, dynamic>> _mockMembers = [
    {
      'id': 1,
      'name': 'John Okello',
      'totalContributions': 150000.0,
      'missedPayments': 0,
      'latePayments': 1,
      'lastActivity': '2 hours ago',
      'lastAmount': 50000.0,
    },
    {
      'id': 2,
      'name': 'Sarah Nambi',
      'totalContributions': 200000.0,
      'missedPayments': 2,
      'latePayments': 1,
      'lastActivity': '5 hours ago',
      'lastAmount': 75000.0,
    },
    {
      'id': 3,
      'name': 'David Musoke',
      'totalContributions': 95000.0,
      'missedPayments': 1,
      'latePayments': 3,
      'lastActivity': '1 day ago',
      'lastAmount': 25000.0,
    },
    {
      'id': 4,
      'name': 'Grace Akello',
      'totalContributions': 180000.0,
      'missedPayments': 0,
      'latePayments': 0,
      'lastActivity': '3 hours ago',
      'lastAmount': 60000.0,
    },
    {
      'id': 5,
      'name': 'Peter Ssali',
      'totalContributions': 120000.0,
      'missedPayments': 3,
      'latePayments': 2,
      'lastActivity': '6 hours ago',
      'lastAmount': 40000.0,
    },
    {
      'id': 6,
      'name': 'Mary Atim',
      'totalContributions': 165000.0,
      'missedPayments': 0,
      'latePayments': 2,
      'lastActivity': '4 hours ago',
      'lastAmount': 55000.0,
    },
  ];

  /// Mock list of savings clusters with member counts and totals
  final List<Map<String, dynamic>> _mockClusters = [
    {
      'id': 1,
      'name': 'Tech Savers',
      'memberCount': 12,
      'totalSavings': 450000.0,
      'color': primaryBlue,
    },
    {
      'id': 2,
      'name': 'University Fund',
      'memberCount': 8,
      'totalSavings': 320000.0,
      'color': successGreen,
    },
    {
      'id': 3,
      'name': 'Business Builders',
      'memberCount': 15,
      'totalSavings': 680000.0,
      'color': warningOrange,
    },
    {
      'id': 4,
      'name': 'Future Leaders',
      'memberCount': 6,
      'totalSavings': 210000.0,
      'color': const Color(0xFF9C27B0),
    },
  ];

  // ==================== CALCULATIONS ====================

  /// Calculate total number of platform members
  int get _totalMembers => _mockMembers.length;

  /// Calculate total number of clusters
  int get _totalClusters => _mockClusters.length;

  /// Calculate total savings across all members
  double get _totalSavings {
    return _mockMembers.fold(
      0.0,
      (sum, member) => sum + (member['totalContributions'] as double),
    );
  }

  /// Calculate number of high-risk members
  /// High risk: missedPayments >= 2 OR latePayments >= 3
  int get _highRiskMembers {
    return _mockMembers.where((member) {
      int missed = member['missedPayments'] as int;
      int late = member['latePayments'] as int;
      return missed >= 2 || late >= 3;
    }).length;
  }

  /// Determine risk level for a member
  String _getRiskLevel(Map<String, dynamic> member) {
    int missed = member['missedPayments'] as int;
    int late = member['latePayments'] as int;

    if (missed >= 2 || late >= 3) {
      return 'High';
    } else if (missed == 1 || late >= 2) {
      return 'Medium';
    } else {
      return 'Low';
    }
  }

  /// Get color for risk level
  Color _getRiskColor(String riskLevel) {
    switch (riskLevel) {
      case 'High':
        return dangerRed;
      case 'Medium':
        return warningOrange;
      case 'Low':
        return successGreen;
      default:
        return textLight;
    }
  }

  /// Format currency in UGX
  String _formatCurrency(double amount) {
    return 'UGX ${amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        )}';
  }

  // ==================== UI BUILD METHODS ====================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              _buildWelcomeHeader(),

              const SizedBox(height: 24),

              // Summary Cards Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSummaryCards(),
              ),

              const SizedBox(height: 28),

              // Recent Activity Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSectionHeader('Recent Activity', Icons.history_rounded),
              ),
              const SizedBox(height: 12),
              _buildRecentActivity(),

              const SizedBox(height: 28),

              // Cluster Overview Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSectionHeader('Cluster Overview', Icons.groups_rounded),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildClusterOverview(),
              ),

              const SizedBox(height: 28),

              // Quick Admin Actions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildSectionHeader('Quick Actions', Icons.admin_panel_settings_rounded),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildQuickActions(),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  /// Build elegant app bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: textDark),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Admin Dashboard',
        style: TextStyle(
          color: textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: softGray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.refresh_rounded, color: textDark),
            onPressed: () {
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Dashboard refreshed'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Build welcome header with gradient background
  Widget _buildWelcomeHeader() {
    return Container(
      margin: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome, Admin',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Platform Overview',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'All systems operational',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.dashboard_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }

  /// Build summary statistics cards
  Widget _buildSummaryCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                title: 'Total Members',
                value: _totalMembers.toString(),
                icon: Icons.people_rounded,
                color: primaryBlue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSummaryCard(
                title: 'Total Clusters',
                value: _totalClusters.toString(),
                icon: Icons.groups_rounded,
                color: successGreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                title: 'Total Savings',
                value: _formatCurrency(_totalSavings),
                icon: Icons.account_balance_wallet_rounded,
                color: warningOrange,
                isLarge: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildSummaryCard(
                title: 'High-Risk',
                value: _highRiskMembers.toString(),
                icon: Icons.warning_rounded,
                color: dangerRed,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build individual summary card
  Widget _buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    bool isLarge = false,
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
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: TextStyle(
              color: textLight,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: textDark,
              fontSize: isLarge ? 16 : 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Build section header
  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: primaryBlue, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textDark,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  /// Build recent activity list
  Widget _buildRecentActivity() {
    final recentMembers = _mockMembers.take(4).toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: recentMembers.length,
        separatorBuilder: (context, index) => const Divider(height: 1, indent: 72),
        itemBuilder: (context, index) {
          final member = recentMembers[index];
          final riskLevel = _getRiskLevel(member);

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getRiskColor(riskLevel).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  member['name'].toString().substring(0, 1),
                  style: TextStyle(
                    color: _getRiskColor(riskLevel),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            title: Text(
              member['name'],
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: textDark,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                '${_formatCurrency(member['lastAmount'])} • ${member['lastActivity']}',
                style: TextStyle(
                  fontSize: 12,
                  color: textLight,
                ),
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getRiskColor(riskLevel).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                riskLevel,
                style: TextStyle(
                  color: _getRiskColor(riskLevel),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Build cluster overview
  Widget _buildClusterOverview() {
    return Column(
      children: _mockClusters.map((cluster) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (cluster['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.groups_rounded,
                  color: cluster['color'] as Color,
                  size: 26,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cluster['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${cluster['memberCount']} members',
                      style: TextStyle(
                        fontSize: 13,
                        color: textLight,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatCurrency(cluster['totalSavings']),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Total Savings',
                    style: TextStyle(
                      fontSize: 11,
                      color: textLight,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Build quick actions grid
  Widget _buildQuickActions() {
    final actions = [
      {
        'title': 'Manage Members',
        'icon': Icons.person_add_rounded,
        'color': primaryBlue,
      },
      {
        'title': 'Manage Clusters',
        'icon': Icons.group_add_rounded,
        'color': successGreen,
      },
      {
        'title': 'View Reports',
        'icon': Icons.assessment_rounded,
        'color': warningOrange,
      },
      {
        'title': 'Risk Monitoring',
        'icon': Icons.warning_amber_rounded,
        'color': dangerRed,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return _buildActionButton(
          title: action['title'] as String,
          icon: action['icon'] as IconData,
          color: action['color'] as Color,
        );
      },
    );
  }

  /// Build individual action button
  Widget _buildActionButton({
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title - Coming Soon'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
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
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
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
}