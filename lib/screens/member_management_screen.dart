import 'package:flutter/material.dart';

/// MEMBER MANAGEMENT SCREEN
/// 
/// Purpose: View, search, filter, and manage all members in the system
/// 
/// Features:
/// - Search members by name, email, or phone
/// - Filter by status, cluster, and risk level
/// - View detailed member information
/// - Edit member details
/// - Suspend/activate accounts
/// - Export member list
/// 
/// All data is MOCK - Replace with Django API calls
class MemberManagementScreen extends StatefulWidget {
  const MemberManagementScreen({super.key});

  @override
  State<MemberManagementScreen> createState() => _MemberManagementScreenState();
}

class _MemberManagementScreenState extends State<MemberManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  String _selectedCluster = 'All Clusters';
  String _selectedRisk = 'All Risk Levels';
  
  // MOCK DATA - Replace with API call to Django: GET /api/admin/members
  final List<Map<String, dynamic>> _allMembers = [
    {
      'id': 1,
      'name': 'Alice Nambi',
      'email': 'alice.nambi@example.com',
      'phone': '+256 700 123 456',
      'cluster': 'Cluster A',
      'total_savings': 5200000,
      'monthly_contribution': 500000,
      'status': 'Active',
      'risk_level': 'Low',
      'joined_date': '2024-01-15',
      'last_payment': '2025-01-27',
      'payment_streak': 12,
    },
    {
      'id': 2,
      'name': 'John Kamau',
      'email': 'john.kamau@example.com',
      'phone': '+256 700 234 567',
      'cluster': 'Cluster A',
      'total_savings': 2800000,
      'monthly_contribution': 500000,
      'status': 'Active',
      'risk_level': 'High',
      'joined_date': '2024-02-10',
      'last_payment': '2024-10-15',
      'payment_streak': 0,
    },
    {
      'id': 3,
      'name': 'Sarah Nakato',
      'email': 'sarah.nakato@example.com',
      'phone': '+256 700 345 678',
      'cluster': 'Cluster C',
      'total_savings': 4100000,
      'monthly_contribution': 350000,
      'status': 'Active',
      'risk_level': 'Medium',
      'joined_date': '2024-01-20',
      'last_payment': '2025-01-20',
      'payment_streak': 8,
    },
    {
      'id': 4,
      'name': 'Peter Okello',
      'email': 'peter.okello@example.com',
      'phone': '+256 700 456 789',
      'cluster': 'Cluster B',
      'total_savings': 1500000,
      'monthly_contribution': 400000,
      'status': 'Inactive',
      'risk_level': 'High',
      'joined_date': '2024-03-05',
      'last_payment': '2024-11-10',
      'payment_streak': 0,
    },
    {
      'id': 5,
      'name': 'Grace Auma',
      'email': 'grace.auma@example.com',
      'phone': '+256 700 567 890',
      'cluster': 'Cluster D',
      'total_savings': 6800000,
      'monthly_contribution': 450000,
      'status': 'Active',
      'risk_level': 'Low',
      'joined_date': '2023-12-01',
      'last_payment': '2025-01-28',
      'payment_streak': 14,
    },
    {
      'id': 6,
      'name': 'Moses Wafula',
      'email': 'moses.wafula@example.com',
      'phone': '+256 700 678 901',
      'cluster': 'Cluster A',
      'total_savings': 3900000,
      'monthly_contribution': 500000,
      'status': 'Active',
      'risk_level': 'Low',
      'joined_date': '2024-01-10',
      'last_payment': '2025-01-25',
      'payment_streak': 13,
    },
  ];

  List<Map<String, dynamic>> get _filteredMembers {
    return _allMembers.where((member) {
      // Search filter
      final searchLower = _searchController.text.toLowerCase();
      final matchesSearch = member['name'].toString().toLowerCase().contains(searchLower) ||
          member['email'].toString().toLowerCase().contains(searchLower) ||
          member['phone'].toString().contains(searchLower);

      // Status filter
      final matchesStatus = _selectedFilter == 'All' || member['status'] == _selectedFilter;

      // Cluster filter
      final matchesCluster = _selectedCluster == 'All Clusters' || member['cluster'] == _selectedCluster;

      // Risk filter
      final matchesRisk = _selectedRisk == 'All Risk Levels' || member['risk_level'] == _selectedRisk;

      return matchesSearch && matchesStatus && matchesCluster && matchesRisk;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredMembers = _filteredMembers;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Member Management',
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'Manage all system members',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Color(0xFF64748B)),
            onPressed: _exportMembers,
          ),
          IconButton(
            icon: const Icon(Icons.person_add, color: Color(0xFF4FC3F7)),
            onPressed: _addNewMember,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and filters
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search bar
                TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'Search by name, email, or phone...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All', _selectedFilter, (value) {
                        setState(() => _selectedFilter = value);
                      }),
                      _buildFilterChip('Active', _selectedFilter, (value) {
                        setState(() => _selectedFilter = value);
                      }),
                      _buildFilterChip('Inactive', _selectedFilter, (value) {
                        setState(() => _selectedFilter = value);
                      }),
                      const SizedBox(width: 8),
                      _buildDropdownFilter(
                        'Cluster',
                        _selectedCluster,
                        ['All Clusters', 'Cluster A', 'Cluster B', 'Cluster C', 'Cluster D'],
                        (value) => setState(() => _selectedCluster = value!),
                      ),
                      const SizedBox(width: 8),
                      _buildDropdownFilter(
                        'Risk Level',
                        _selectedRisk,
                        ['All Risk Levels', 'Low', 'Medium', 'High'],
                        (value) => setState(() => _selectedRisk = value!),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Member count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: const Color(0xFFF8FAFC),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredMembers.length} members found',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
                if (_searchController.text.isNotEmpty ||
                    _selectedFilter != 'All' ||
                    _selectedCluster != 'All Clusters' ||
                    _selectedRisk != 'All Risk Levels')
                  TextButton(
                    onPressed: _clearFilters,
                    child: const Text('Clear Filters'),
                  ),
              ],
            ),
          ),

          // Member list
          Expanded(
            child: filteredMembers.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredMembers.length,
                    itemBuilder: (context, index) {
                      return _buildMemberCard(filteredMembers[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String selectedValue, Function(String) onSelected) {
    final isSelected = selectedValue == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) => onSelected(label),
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF4FC3F7).withValues(alpha: 0.2),
        labelStyle: TextStyle(
          color: isSelected ? const Color(0xFF4FC3F7) : const Color(0xFF64748B),
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
        side: BorderSide(
          color: isSelected ? const Color(0xFF4FC3F7) : const Color(0xFFE2E8F0),
        ),
      ),
    );
  }

  Widget _buildDropdownFilter(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down, size: 20),
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF64748B),
          fontWeight: FontWeight.w500,
        ),
        items: items.map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildMemberCard(Map<String, dynamic> member) {
    final riskColor = member['risk_level'] == 'High'
        ? const Color(0xFFEF5350)
        : member['risk_level'] == 'Medium'
            ? const Color(0xFFFF9800)
            : const Color(0xFF10B981);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _viewMemberDetails(member),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color(0xFF4FC3F7).withValues(alpha: 0.1),
                    child: Text(
                      member['name'].toString().substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4FC3F7),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Member info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              member['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: member['status'] == 'Active'
                                    ? const Color(0xFF10B981).withValues(alpha: 0.1)
                                    : const Color(0xFF64748B).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                member['status'],
                                style: TextStyle(
                                  color: member['status'] == 'Active'
                                      ? const Color(0xFF10B981)
                                      : const Color(0xFF64748B),
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          member['email'],
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 12, color: const Color(0xFF94A3B8)),
                            const SizedBox(width: 4),
                            Text(
                              member['phone'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Risk badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: riskColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.warning_rounded, color: riskColor, size: 16),
                        const SizedBox(height: 2),
                        Text(
                          member['risk_level'],
                          style: TextStyle(
                            color: riskColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Stats row
              Row(
                children: [
                  _buildMemberStat(
                    Icons.account_balance_wallet,
                    'Savings',
                    _formatCurrency(member['total_savings']),
                  ),
                  _buildMemberStat(
                    Icons.groups,
                    'Cluster',
                    member['cluster'],
                  ),
                  _buildMemberStat(
                    Icons.local_fire_department,
                    'Streak',
                    '${member['payment_streak']} months',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => _editMember(member),
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Edit'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF4FC3F7),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => _contactMember(member),
                    icon: const Icon(Icons.message, size: 16),
                    label: const Text('Contact'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF10B981),
                    ),
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert, size: 20, color: Color(0xFF64748B)),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'view_history',
                        child: Row(
                          children: [
                            Icon(Icons.history, size: 18),
                            SizedBox(width: 8),
                            Text('Payment History'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'suspend',
                        child: Row(
                          children: [
                            Icon(
                              member['status'] == 'Active' ? Icons.block : Icons.check_circle,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(member['status'] == 'Active' ? 'Suspend' : 'Activate'),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'view_history') {
                        _viewPaymentHistory(member);
                      } else if (value == 'suspend') {
                        _toggleMemberStatus(member);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemberStat(IconData icon, String label, String value) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 14, color: const Color(0xFF64748B)),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: const Color(0xFF94A3B8).withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No members found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Try adjusting your filters',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _selectedFilter = 'All';
      _selectedCluster = 'All Clusters';
      _selectedRisk = 'All Risk Levels';
    });
  }

  void _viewMemberDetails(Map<String, dynamic> member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(member['name']),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Email', member['email']),
              _buildDetailRow('Phone', member['phone']),
              _buildDetailRow('Cluster', member['cluster']),
              _buildDetailRow('Total Savings', _formatCurrency(member['total_savings'])),
              _buildDetailRow('Monthly Contribution', _formatCurrency(member['monthly_contribution'])),
              _buildDetailRow('Status', member['status']),
              _buildDetailRow('Risk Level', member['risk_level']),
              _buildDetailRow('Joined', member['joined_date']),
              _buildDetailRow('Last Payment', member['last_payment']),
              _buildDetailRow('Payment Streak', '${member['payment_streak']} months'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _editMember(Map<String, dynamic> member) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit ${member['name']}')),
    );
  }

  void _contactMember(Map<String, dynamic> member) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contact ${member['name']}')),
    );
  }

  void _viewPaymentHistory(Map<String, dynamic> member) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment history for ${member['name']}')),
    );
  }

  void _toggleMemberStatus(Map<String, dynamic> member) {
    final newStatus = member['status'] == 'Active' ? 'Inactive' : 'Active';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${member['name']} set to $newStatus')),
    );
  }

  void _exportMembers() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exporting members...')),
    );
  }

  void _addNewMember() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add new member - Coming soon')),
    );
  }

  String _formatCurrency(int amount) {
    if (amount >= 1000000) {
      return 'UGX ${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return 'UGX ${(amount / 1000).toStringAsFixed(0)}K';
    }
    return 'UGX $amount';
  }
}