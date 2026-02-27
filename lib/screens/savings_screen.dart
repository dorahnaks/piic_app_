import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/constants.dart';

// Fixed: Removed 'abstract' keyword so the class can be instantiated
class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _contributions;

  @override
  void initState() {
    super.initState();
    _contributions = _apiService.getContributions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('My Savings', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _contributions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryBlue));
          }

          final contributions = snapshot.data ?? [];

          if (contributions.isEmpty) {
            return const Center(child: Text('No savings found.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contributions.length,
              itemBuilder: (context, index) {
                final item = contributions[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: AppColors.primaryBlue.withValues(alpha: 0.1), shape: BoxShape.circle),
                        child: const Icon(Icons.savings, color: AppColors.primaryBlue),
                      ),
                      title: Text("UGX ${item['amount']}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(item['status'] ?? 'Pending'),
                      trailing: Text(item['payment_date'] ?? '', style: const TextStyle(fontSize: 12)),
                    ),
                  ),
                );
              },
            ),
          );
        },
      )
    );
  }
}