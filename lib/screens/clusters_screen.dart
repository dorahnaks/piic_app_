import 'package:flutter/material.dart';

class ClustersScreen extends StatelessWidget {
  const ClustersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Savings Clusters"),
        backgroundColor: const Color(0xFF4DA3FF),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          clusterCard(
            name: "Cluster A",
            package: "Plot Package",
            members: "45 Members",
            target: "UGX 4,300,000",
            status: "Active",
          ),
          clusterCard(
            name: "Cluster B",
            package: "Farmland Package",
            members: "38 Members",
            target: "UGX 5,500,000",
            status: "Completed",
          ),
          clusterCard(
            name: "Cluster C",
            package: "Housing Package",
            members: "50 Members",
            target: "UGX 90,000,000",
            status: "Active",
          ),
        ],
      ),
    );
  }
}

class clusterCard extends StatelessWidget {
  final String name;
  final String package;
  final String members;
  final String target;
  final String status;

  const clusterCard({
    super.key,
    required this.name,
    required this.package,
    required this.members,
    required this.target,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final bool completed = status == "Completed";

    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              completed ? Colors.green : const Color(0xFF4DA3FF),
          child: const Icon(Icons.groups, color: Colors.white),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("$package\n$members"),
        isThreeLine: true,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              status,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: completed ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              target,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
