import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/constants.dart';

class ClustersScreen extends StatefulWidget {
  const ClustersScreen({super.key});

  @override
  State<ClustersScreen> createState() => _ClustersScreenState();
}

class _ClustersScreenState extends State<ClustersScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _clusters;

  @override
  void initState() {
    super.initState();
    _clusters = _apiService.getClusters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('My Clusters', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _clusters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.successGreen));
          }

          final clusters = snapshot.data ?? [];

          if (clusters.isEmpty) {
            return const Center(child: Text('No clusters found.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: clusters.length,
                itemBuilder: (context, index) {
                  final item = clusters[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: AppColors.successGreen.withValues(alpha: 0.1), shape: BoxShape.circle),
                          child: Icon(Icons.group, color: AppColors.successGreen),
                        ),
                        title: Text(item['name'] ?? 'Cluster'),
                        subtitle: Text("Code: ${item['code'] ?? 'N/A'}"),
                      ),
                    ),
                  );
                },
              ),
            );
        },
      ),
    );
  }
}