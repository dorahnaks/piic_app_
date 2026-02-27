import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/constants.dart';
import 'savings_screen.dart';
import 'clusters_screen.dart';
import 'investments_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  late Future<Map<String, dynamic>> _dashboardData;

  Future<Map<String, dynamic>> _fetchData() async {
    final profile = await _apiService.getProfile();
    final contributions = await _apiService.getContributions();
    
    double totalSavings = 0.0;
    for (var item in contributions) {
      if (item['status'] == 'CONFIRMED') {
        totalSavings += double.parse(item['amount'].toString());
      }
    }
    
    return {
      'profile': profile,
      'totalSavings': totalSavings,
    };
  }

  @override
  void initState() {
    super.initState();
    _dashboardData = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      drawer: _buildDrawer(context),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dashboardData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryBlue));
          }
          
          final data = snapshot.data ?? {};
          final profile = data['profile'] as Map<String, dynamic>? ?? {};
          final totalSavings = data['totalSavings'] as double? ?? 0.0;

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(context, profile['full_name'] ?? 'User'),
                  const SizedBox(height: 24),
                  _buildBalanceCard(totalSavings),
                  const SizedBox(height: 32),
                  _buildServicesGrid(context),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryBlue, AppColors.darkBlue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(radius: 30, backgroundColor: Colors.white, child: Icon(Icons.person, color: AppColors.darkBlue, size: 30)),
                  const SizedBox(height: 12),
                  const Text('PIIC Member', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Cluster: Active', style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(Icons.savings, 'Savings', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SavingsScreen()))),
                _buildDrawerItem(Icons.group, 'Clusters', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ClustersScreen()))),
                _buildDrawerItem(Icons.work, 'Investments', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InvestmentsScreen()))),
                _buildDrawerItem(Icons.person, 'Profile', () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()))),
                const Divider(),
                _buildDrawerItem(Icons.logout, 'Logout', () async {
                  await _apiService.logout();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                }, color: AppColors.dangerRed),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.primaryBlue),
      title: Text(title, style: TextStyle(color: color ?? Colors.black87, fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }

  Widget _buildHeader(BuildContext context, String name) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black87),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Welcome Back", style: TextStyle(color: Colors.black54, fontSize: 14)),
                  Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                ],
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
            child: IconButton(icon: const Icon(Icons.notifications_none_rounded, color: Colors.black87), onPressed: () {}),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(double total) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryBlue, AppColors.darkBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppColors.primaryBlue.withValues(alpha: 0.4), blurRadius: 15, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Total Savings", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text("UGX ${total.toStringAsFixed(0)}", style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                child: const Row(
                  children: [
                    Icon(Icons.trending_up, color: Colors.white, size: 16),
                    SizedBox(width: 6),
                    Text("Active", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      {'icon': Icons.savings, 'title': 'Savings', 'color': AppColors.darkBlue},
      {'icon': Icons.group, 'title': 'Clusters', 'color': AppColors.successGreen},
      {'icon': Icons.home_work, 'title': 'Investments', 'color': AppColors.warningOrange},
      {'icon': Icons.person, 'title': 'Profile', 'color': AppColors.primaryBlue},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          crossAxisSpacing: 15, 
          mainAxisSpacing: 15, 
          childAspectRatio: 1.2
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final serviceColor = services[index]['color'] as Color;
          
          return GestureDetector(
            onTap: () {
              if (index == 0) Navigator.push(context, MaterialPageRoute(builder: (_) => const SavingsScreen()));
              else if (index == 1) Navigator.push(context, MaterialPageRoute(builder: (_) => const ClustersScreen()));
              else if (index == 2) Navigator.push(context, MaterialPageRoute(builder: (_) => const InvestmentsScreen()));
              else if (index == 3) Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(16), 
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: serviceColor.withValues(alpha: 0.15), 
                      shape: BoxShape.circle
                    ),
                    child: Icon(services[index]['icon'] as IconData, color: serviceColor, size: 28),
                  ),
                  const SizedBox(height: 12),
                  Text(services[index]['title'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppColors.textDark)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}