import 'package:flutter/material.dart';

/// PIIC ClusterSave - Cluster Details Screen
/// 
/// Detailed view of individual cluster information
/// Features: Cluster stats, member list, activity timeline, settings

class ClusterDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> cluster;

  const ClusterDetailsScreen({super.key, required this.cluster});

  @override
  State<ClusterDetailsScreen> createState() => _ClusterDetailsScreenState();
}

class _ClusterDetailsScreenState extends State<ClusterDetailsScreen> with SingleTickerProviderStateMixin {
  // PIIC Brand Colors
  static const Color primaryBlue = Color(0xFF4FC3F7);
  static const Color deepBlue = Color(0xFF0288D1);
  static const Color softGray = Color(0xFFF5F7FA);
  static const Color textDark = Color(0xFF2D3748);
  static const Color textLight = Color(0xFF718096);
  static const Color successGreen = Color(0xFF66BB6A);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color dangerRed = Color(0xFFEF5350);

  late TabController _tabController;

  // Mock cluster members
  final List<Map<String, dynamic>> _clusterMembers = [
    {
      'name': 'John Okello',
      'contribution': 45000.0,
      'status': 'Active',
      'joinDate': '2024-01-15',
      'compliance': 95,
    },
    {
      'name': 'Sarah Nambi',
      'contribution': 60000.0,
      'status': 'Active',
      'joinDate': '2023-12-10',
      'compliance': 88,
    },
    {
      'name': 'David Musoke',
      'contribution': 30000.0,
      'status': 'Active',
      'joinDate': '2024-02-05',
      'compliance': 72,
    },
    {
      'name': 'Grace Akello',
      'contribution': 55000.0,
      'status': 'Active',
      'joinDate': '2024-01-20',
      'compliance': 100,
    },
  ];

  // Mock activity timeline
  final List<Map<String, dynamic>> _activities = [
    {
      'type': 'contribution',
      'member': 'Sarah Nambi',
      'amount': 60000.0,
      'time': '2 hours ago',
      'icon': Icons.payments_rounded,
      'color': Color(0xFF66BB6A),
    },
    {
      'type': 'join',
      'member': 'David Musoke',
      'time': '1 day ago',
      'icon': Icons.person_add_rounded,
      'color': Color(0xFF4FC3F7),
    },
    {
      'type': 'milestone',
      'description': 'Reached 50% of savings goal',
      'time': '3 days ago',
      'icon': Icons.emoji_events_rounded,
      'color': Color(0xFFFF9800),
    },
    {
      'type': 'contribution',
      'member': 'John Okello',
      'amount': 45000.0,
      'time': '5 days ago',
      'icon': Icons.payments_rounded,
      'color': Color(0xFF66BB6A),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatCurrency(double amount) {
    return 'UGX ${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Elegant App Bar with Gradient
          _buildSliverAppBar(),

          // Tab Bar
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                labelColor: primaryBlue,
                unselectedLabelColor: textLight,
                indicatorColor: primaryBlue,
                indicatorWeight: 3,
                labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Members'),
                  Tab(text: 'Activity'),
                ],
              ),
            ),
          ),

          // Tab Content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(),
                _buildMembersTab(),
                _buildActivityTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      elevation: 0,
      backgroundColor: primaryBlue,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_rounded, color: Colors.white),
          onPressed: () => _showClusterSettings(),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryBlue, deepBlue],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.groups_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cluster['name'] ?? 'Cluster Name',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${widget.cluster['memberCount'] ?? 0} members • Active',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    final totalSavings = widget.cluster['totalSavings'] ?? 0.0;
    final savingsGoal = 1000000.0;
    final progress = (totalSavings / savingsGoal * 100).clamp(0, 100);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Savings Progress Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)],
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
                const Text(
                  'Savings Progress',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatCurrency(totalSavings),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'of ${_formatCurrency(savingsGoal)} goal',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress / 100,
                    backgroundColor: Colors.white.withValues(alpha: 0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${progress.toStringAsFixed(1)}% complete',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Quick Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Avg/Member',
                  _formatCurrency(totalSavings / (widget.cluster['memberCount'] ?? 1)),
                  Icons.person_rounded,
                  primaryBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'This Month',
                  _formatCurrency(120000),
                  Icons.calendar_today_rounded,
                  successGreen,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Section: Key Metrics
          _buildSectionHeader('Key Metrics'),
          const SizedBox(height: 12),
          _buildMetricsList(),

          const SizedBox(height: 24),

          // Section: Recent Milestones
          _buildSectionHeader('Recent Milestones'),
          const SizedBox(height: 12),
          _buildMilestones(),
        ],
      ),
    );
  }

  Widget _buildMembersTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _clusterMembers.length,
      itemBuilder: (context, index) {
        final member = _clusterMembers[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  member['name'].toString().substring(0, 1),
                  style: const TextStyle(
                    color: primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            title: Text(
              member['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: textDark,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'Joined ${member['joinDate']}',
                  style: TextStyle(fontSize: 12, color: textLight),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      _formatCurrency(member['contribution']),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getComplianceColor(member['compliance']).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${member['compliance']}% compliant',
                        style: TextStyle(
                          color: _getComplianceColor(member['compliance']),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: const Icon(Icons.chevron_right_rounded, color: primaryBlue),
          ),
        );
      },
    );
  }

  Widget _buildActivityTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _activities.length,
      itemBuilder: (context, index) {
        final activity = _activities[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (activity['color'] as Color).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  activity['icon'] as IconData,
                  color: activity['color'] as Color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (activity['type'] == 'contribution') ...[
                      Text(
                        activity['member'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: textDark,
                        ),
                      ),
                      Text(
                        'Contributed ${_formatCurrency(activity['amount'])}',
                        style: TextStyle(fontSize: 14, color: textLight),
                      ),
                    ] else if (activity['type'] == 'join') ...[
                      Text(
                        activity['member'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: textDark,
                        ),
                      ),
                      Text(
                        'Joined the cluster',
                        style: TextStyle(fontSize: 14, color: textLight),
                      ),
                    ] else ...[
                      Text(
                        activity['description'] ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: textDark,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      activity['time'],
                      style: TextStyle(fontSize: 12, color: textLight),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
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
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(color: textLight, fontSize: 12, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(color: textDark, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: textDark,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildMetricsList() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: softGray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildMetricRow('Active Members', '${widget.cluster['memberCount']}'),
          const Divider(height: 24),
          _buildMetricRow('Monthly Target', _formatCurrency(200000)),
          const Divider(height: 24),
          _buildMetricRow('Completion Rate', '${((widget.cluster['totalSavings'] ?? 0) / 1000000 * 100).toStringAsFixed(1)}%'),
          const Divider(height: 24),
          _buildMetricRow('Next Payout', 'December 2024'),
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: textLight)),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textDark),
        ),
      ],
    );
  }

  Widget _buildMilestones() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFE082)),
      ),
      child: Column(
        children: [
          _buildMilestone(Icons.emoji_events_rounded, 'Reached 50% savings goal', '3 days ago'),
          const SizedBox(height: 12),
          _buildMilestone(Icons.people_rounded, '10 members milestone', '2 weeks ago'),
          const SizedBox(height: 12),
          _buildMilestone(Icons.celebration_rounded, 'Cluster created', '6 months ago'),
        ],
      ),
    );
  }

  Widget _buildMilestone(IconData icon, String title, String time) {
    return Row(
      children: [
        Icon(icon, color: warningOrange, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textDark),
              ),
              Text(time, style: TextStyle(fontSize: 12, color: textLight)),
            ],
          ),
        ),
      ],
    );
  }

  Color _getComplianceColor(int compliance) {
    if (compliance >= 90) return successGreen;
    if (compliance >= 70) return warningOrange;
    return dangerRed;
  }

  void _showClusterSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Cluster Settings - Coming Soon'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// Custom SliverAppBarDelegate for TabBar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}