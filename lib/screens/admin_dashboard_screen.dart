import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  String _selectedCluster = 'All Clusters';
  
  // Mock data - will be replaced with Django API calls
  final Map<String, dynamic> _overallStats = {
    'total_users': 1247,
    'active_clusters': 45,
    'total_savings': 458750000, // UGX
    'total_investments': 325000000, // UGX
  };

  // Cluster-specific data with calculations
  final List<Map<String, dynamic>> _clusters = [
    {
      'name': 'Cluster A',
      'members': 28,
      'total_savings': 125000000,
      'status': 'Active',
      'monthly_contribution': 500000,
    },
    {
      'name': 'Cluster B',
      'members': 35,
      'total_savings': 98000000,
      'status': 'Active',
      'monthly_contribution': 400000,
    },
    {
      'name': 'Cluster C',
      'members': 22,
      'total_savings': 87500000,
      'status': 'Active',
      'monthly_contribution': 350000,
    },
    {
      'name': 'Cluster D',
      'members': 31,
      'total_savings': 76250000,
      'status': 'Active',
      'monthly_contribution': 450000,
    },
    {
      'name': 'Cluster E',
      'members': 18,
      'total_savings': 72000000,
      'status': 'Active',
      'monthly_contribution': 300000,
    },
  ];

  // Calculate totals for selected cluster or all
  Map<String, dynamic> _calculateFinancials() {
    int totalSavings = 0;
    
    if (_selectedCluster == 'All Clusters') {
      totalSavings = _overallStats['total_savings'];
    } else {
      final cluster = _clusters.firstWhere(
        (c) => c['name'] == _selectedCluster,
        orElse: () => {'total_savings': 0},
      );
      totalSavings = cluster['total_savings'];
    }

    // Tax Calculations (Uganda)
    final withholdingTax = (totalSavings * 0.15).round(); // 15% WHT on interest
    final localServiceTax = (totalSavings * 0.05).round(); // 5% local service tax
    
    // Platform Fees
    final managementFee = (totalSavings * 0.02).round(); // 2% management fee
    final transactionFee = (totalSavings * 0.01).round(); // 1% transaction fee
    
    final totalDeductions = withholdingTax + localServiceTax + managementFee + transactionFee;
    final netAmount = totalSavings - totalDeductions;

    return {
      'total_savings': totalSavings,
      'withholding_tax': withholdingTax,
      'local_service_tax': localServiceTax,
      'management_fee': managementFee,
      'transaction_fee': transactionFee,
      'total_deductions': totalDeductions,
      'net_amount': netAmount,
    };
  }

  @override
  Widget build(BuildContext context) {
    final financials = _calculateFinancials();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFF64748B)),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cluster Selector Card
            _buildClusterSelector(),

            const SizedBox(height: 20),

            // Quick Stats Overview
            _buildQuickStats(),

            const SizedBox(height: 24),

            // Financial Breakdown Card
            _buildFinancialBreakdown(financials),

            const SizedBox(height: 24),

            // Tax Explanation Card
            _buildTaxExplanation(),

            const SizedBox(height: 24),

            // Cluster Details
            if (_selectedCluster == 'All Clusters') ...[
              _buildSectionHeader('All Clusters Overview'),
              const SizedBox(height: 12),
              _buildAllClustersView(),
            ] else ...[
              _buildSectionHeader('Cluster Details'),
              const SizedBox(height: 12),
              _buildClusterDetails(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildClusterSelector() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4FC3F7).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Cluster',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButton<String>(
              value: _selectedCluster,
              isExpanded: true,
              underline: const SizedBox(),
              dropdownColor: const Color(0xFF0288D1),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              items: [
                'All Clusters',
                ..._clusters.map((c) => c['name'] as String),
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCluster = newValue!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    final financials = _calculateFinancials();
    
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        _buildStatCard(
          title: 'Total Savings',
          value: _formatCurrency(financials['total_savings']),
          icon: Icons.account_balance_wallet,
          color: const Color(0xFF4FC3F7),
        ),
        _buildStatCard(
          title: 'Net Amount',
          value: _formatCurrency(financials['net_amount']),
          icon: Icons.payments,
          color: const Color(0xFF10B981),
        ),
        _buildStatCard(
          title: 'Total Taxes',
          value: _formatCurrency(
            financials['withholding_tax'] + financials['local_service_tax']
          ),
          icon: Icons.receipt_long,
          color: const Color(0xFFFF9800),
        ),
        _buildStatCard(
          title: 'Platform Fees',
          value: _formatCurrency(
            financials['management_fee'] + financials['transaction_fee']
          ),
          icon: Icons.business_center,
          color: const Color(0xFF9C27B0),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialBreakdown(Map<String, dynamic> financials) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Financial Breakdown',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 20),

          // Total Savings
          _buildBreakdownRow(
            label: 'Total Savings',
            amount: financials['total_savings'],
            color: const Color(0xFF4FC3F7),
            isTotal: true,
          ),
          
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          // Deductions Header
          const Text(
            'Deductions',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 12),

          // Taxes
          _buildBreakdownRow(
            label: 'Withholding Tax (15%)',
            amount: financials['withholding_tax'],
            color: const Color(0xFFFF9800),
            showInfo: true,
            infoText: 'Government tax on interest earned',
          ),
          const SizedBox(height: 8),
          _buildBreakdownRow(
            label: 'Local Service Tax (5%)',
            amount: financials['local_service_tax'],
            color: const Color(0xFFFF9800),
            showInfo: true,
            infoText: 'Local government service charge',
          ),
          
          const SizedBox(height: 12),

          // Platform Fees
          _buildBreakdownRow(
            label: 'Management Fee (2%)',
            amount: financials['management_fee'],
            color: const Color(0xFF9C27B0),
            showInfo: true,
            infoText: 'Platform operation & maintenance',
          ),
          const SizedBox(height: 8),
          _buildBreakdownRow(
            label: 'Transaction Fee (1%)',
            amount: financials['transaction_fee'],
            color: const Color(0xFF9C27B0),
            showInfo: true,
            infoText: 'Processing & banking charges',
          ),

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),

          // Net Amount
          _buildBreakdownRow(
            label: 'Net Amount Available',
            amount: financials['net_amount'],
            color: const Color(0xFF10B981),
            isNet: true,
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownRow({
    required String label,
    required int amount,
    required Color color,
    bool isTotal = false,
    bool isNet = false,
    bool showInfo = false,
    String? infoText,
  }) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: isTotal || isNet ? 16 : 14,
                    fontWeight: isTotal || isNet ? FontWeight.bold : FontWeight.w500,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ),
              if (showInfo && infoText != null)
                Tooltip(
                  message: infoText,
                  child: const Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Color(0xFF94A3B8),
                  ),
                ),
            ],
          ),
        ),
        Text(
          _formatCurrency(amount),
          style: TextStyle(
            fontSize: isTotal || isNet ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: isNet ? color : const Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  Widget _buildTaxExplanation() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4FC3F7).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4FC3F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.lightbulb_outline,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Understanding Deductions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildExplanationItem(
            title: 'Taxes (20% total)',
            description: 'Mandatory government taxes: 15% withholding tax on interest + 5% local service tax',
          ),
          const SizedBox(height: 12),
          _buildExplanationItem(
            title: 'Platform Fees (3% total)',
            description: '2% management fee for operations + 1% transaction processing fee',
          ),
          const SizedBox(height: 12),
          _buildExplanationItem(
            title: 'Your Money',
            description: 'The net amount (77% of savings) is available for investment in real estate',
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationItem({
    required String title,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF64748B),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1E293B),
      ),
    );
  }

  Widget _buildAllClustersView() {
    return Column(
      children: _clusters.map((cluster) {
        final clusterFinancials = {
          'total_savings': cluster['total_savings'],
          'withholding_tax': (cluster['total_savings'] * 0.15).round(),
          'local_service_tax': (cluster['total_savings'] * 0.05).round(),
          'management_fee': (cluster['total_savings'] * 0.02).round(),
          'transaction_fee': (cluster['total_savings'] * 0.01).round(),
        };
        final totalDeductions = clusterFinancials['withholding_tax']! + 
                                 clusterFinancials['local_service_tax']! +
                                 clusterFinancials['management_fee']! +
                                 clusterFinancials['transaction_fee']!;
        final netAmount = cluster['total_savings'] - totalDeductions;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4FC3F7).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.groups,
                          color: Color(0xFF4FC3F7),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cluster['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          Text(
                            '${cluster['members']} members',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Active',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildClusterMetric('Savings', _formatCurrency(cluster['total_savings'])),
                  _buildClusterMetric('Net', _formatCurrency(netAmount)),
                  _buildClusterMetric('Deductions', _formatCurrency(totalDeductions)),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildClusterMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
      ],
    );
  }

  Widget _buildClusterDetails() {
    final cluster = _clusters.firstWhere((c) => c['name'] == _selectedCluster);
    final financials = _calculateFinancials();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF4FC3F7).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.groups,
                  color: Color(0xFF4FC3F7),
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cluster['name'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    '${cluster['members']} active members',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildDetailRow('Total Savings', _formatCurrency(cluster['total_savings'])),
          _buildDetailRow('Monthly Contribution', _formatCurrency(cluster['monthly_contribution'])),
          _buildDetailRow('Average per Member', _formatCurrency((cluster['total_savings'] / cluster['members']).round())),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          _buildDetailRow('Net Available', _formatCurrency(financials['net_amount']), isHighlight: true),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isHighlight ? 16 : 14,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isHighlight ? 18 : 16,
              fontWeight: FontWeight.bold,
              color: isHighlight ? const Color(0xFF10B981) : const Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(int amount) {
    if (amount >= 1000000) {
      return 'UGX ${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return 'UGX ${(amount / 1000).toStringAsFixed(0)}K';
    }
    return 'UGX ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }
}