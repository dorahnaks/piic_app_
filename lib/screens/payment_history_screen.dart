import 'package:flutter/material.dart';

/// PIIC ClusterSave - Payment History Screen
/// 
/// Comprehensive transaction and payment tracking
/// Features: Transaction list, filters, search, payment details, export

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  // PIIC Brand Colors
  static const Color primaryBlue = Color(0xFF4FC3F7);
  static const Color deepBlue = Color(0xFF0288D1);
  static const Color softGray = Color(0xFFF5F7FA);
  static const Color textDark = Color(0xFF2D3748);
  static const Color textLight = Color(0xFF718096);
  static const Color successGreen = Color(0xFF66BB6A);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color dangerRed = Color(0xFFEF5350);

  String _filterStatus = 'All';
  String _filterPeriod = 'All Time';

  // Mock payment data
  final List<Map<String, dynamic>> _allPayments = [
    {
      'id': 'TXN-2024-001',
      'member': 'Sarah Nambi',
      'cluster': 'Tech Savers',
      'amount': 75000.0,
      'type': 'Contribution',
      'status': 'Completed',
      'date': '2024-01-28',
      'time': '14:30',
      'method': 'Mobile Money',
      'reference': 'MM-78945612',
    },
    {
      'id': 'TXN-2024-002',
      'member': 'John Okello',
      'cluster': 'Business Builders',
      'amount': 50000.0,
      'type': 'Contribution',
      'status': 'Completed',
      'date': '2024-01-28',
      'time': '10:15',
      'method': 'Bank Transfer',
      'reference': 'BT-45612378',
    },
    {
      'id': 'TXN-2024-003',
      'member': 'Grace Akello',
      'cluster': 'University Fund',
      'amount': 120000.0,
      'type': 'Withdrawal',
      'status': 'Pending',
      'date': '2024-01-27',
      'time': '16:45',
      'method': 'Mobile Money',
      'reference': 'MM-96385274',
    },
    {
      'id': 'TXN-2024-004',
      'member': 'David Musoke',
      'cluster': 'Tech Savers',
      'amount': 25000.0,
      'type': 'Contribution',
      'status': 'Failed',
      'date': '2024-01-27',
      'time': '09:20',
      'method': 'Mobile Money',
      'reference': 'MM-15973428',
    },
    {
      'id': 'TXN-2024-005',
      'member': 'Mary Atim',
      'cluster': 'Future Leaders',
      'amount': 55000.0,
      'type': 'Contribution',
      'status': 'Completed',
      'date': '2024-01-26',
      'time': '11:30',
      'method': 'Bank Transfer',
      'reference': 'BT-75319864',
    },
    {
      'id': 'TXN-2024-006',
      'member': 'Peter Ssali',
      'cluster': 'Business Builders',
      'amount': 40000.0,
      'type': 'Contribution',
      'status': 'Completed',
      'date': '2024-01-25',
      'time': '15:10',
      'method': 'Mobile Money',
      'reference': 'MM-35791468',
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed': return successGreen;
      case 'Pending': return warningOrange;
      case 'Failed': return dangerRed;
      default: return textLight;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'Contribution': return Icons.arrow_downward_rounded;
      case 'Withdrawal': return Icons.arrow_upward_rounded;
      default: return Icons.swap_horiz_rounded;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Contribution': return successGreen;
      case 'Withdrawal': return primaryBlue;
      default: return textLight;
    }
  }

  String _formatCurrency(double amount) {
    return 'UGX ${amount.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }

  List<Map<String, dynamic>> get _filteredPayments {
    return _allPayments.where((payment) {
      if (_filterStatus != 'All' && payment['status'] != _filterStatus) {
        return false;
      }
      // Add period filtering logic here
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPayments = _filteredPayments;
    final totalAmount = filteredPayments.fold(0.0, (sum, p) => sum + (p['amount'] as double));
    final completedCount = filteredPayments.where((p) => p['status'] == 'Completed').length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Summary Header
          _buildSummaryHeader(filteredPayments.length, completedCount, totalAmount),

          // Filters
          _buildFilters(),

          // Payments List
          Expanded(
            child: filteredPayments.isEmpty
                ? _buildEmptyState()
                : _buildPaymentsList(filteredPayments),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: textDark),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Payment History',
        style: TextStyle(
          color: textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.file_download_rounded, color: primaryBlue),
          onPressed: () => _exportPayments(),
        ),
      ],
    );
  }

  Widget _buildSummaryHeader(int total, int completed, double amount) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Transactions',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                '$total transactions',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Value',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatCurrency(amount),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$completed completed',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: softGray,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildFilterDropdown(
              'Status',
              _filterStatus,
              ['All', 'Completed', 'Pending', 'Failed'],
              (value) => setState(() => _filterStatus = value),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildFilterDropdown(
              'Period',
              _filterPeriod,
              ['All Time', 'Today', 'This Week', 'This Month'],
              (value) => setState(() => _filterPeriod = value),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(String label, String value, List<String> options, Function(String) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down, color: primaryBlue, size: 20),
        style: const TextStyle(fontSize: 14, color: textDark, fontWeight: FontWeight.w500),
        items: options.map((option) {
          return DropdownMenuItem<String>(value: option, child: Text(option));
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null) onChanged(newValue);
        },
      ),
    );
  }

  Widget _buildPaymentsList(List<Map<String, dynamic>> payments) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: payments.length,
      itemBuilder: (context, index) {
        final payment = payments[index];
        return _buildPaymentCard(payment);
      },
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: InkWell(
        onTap: () => _showPaymentDetails(payment),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getTypeColor(payment['type']).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getTypeIcon(payment['type']),
                  color: _getTypeColor(payment['type']),
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          payment['member'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: textDark,
                          ),
                        ),
                        Text(
                          _formatCurrency(payment['amount']),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${payment['cluster']} • ${payment['date']} ${payment['time']}',
                      style: TextStyle(fontSize: 12, color: textLight),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(payment['status']).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            payment['status'],
                            style: TextStyle(
                              color: _getStatusColor(payment['status']),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          payment['method'],
                          style: TextStyle(fontSize: 11, color: textLight),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_rounded, size: 64, color: textLight),
          const SizedBox(height: 16),
          const Text(
            'No transactions found',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textDark),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters',
            style: TextStyle(fontSize: 14, color: textLight),
          ),
        ],
      ),
    );
  }

  void _showPaymentDetails(Map<String, dynamic> payment) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transaction Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Amount
            Center(
              child: Column(
                children: [
                  Text(
                    _formatCurrency(payment['amount']),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: _getStatusColor(payment['status']).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      payment['status'],
                      style: TextStyle(
                        color: _getStatusColor(payment['status']),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Details
            _buildDetailRow('Transaction ID', payment['id']),
            _buildDetailRow('Member', payment['member']),
            _buildDetailRow('Cluster', payment['cluster']),
            _buildDetailRow('Type', payment['type']),
            _buildDetailRow('Method', payment['method']),
            _buildDetailRow('Reference', payment['reference']),
            _buildDetailRow('Date', '${payment['date']} at ${payment['time']}'),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: textLight)),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textDark,
            ),
          ),
        ],
      ),
    );
  }

  void _exportPayments() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Export to CSV - Coming Soon'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}