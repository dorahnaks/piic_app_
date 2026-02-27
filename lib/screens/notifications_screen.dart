import 'package:flutter/material.dart';

/// PIIC ClusterSave - Notifications Screen
/// 
/// Centralized notification and alert management
/// Features: Categorized notifications, read/unread status, quick actions

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // PIIC Brand Colors
  static const Color primaryBlue = Color(0xFF4FC3F7);
  static const Color softGray = Color(0xFFF5F7FA);
  static const Color textDark = Color(0xFF2D3748);
  static const Color textLight = Color(0xFF718096);
  static const Color dangerRed = Color(0xFFEF5350);

  String _selectedTab = 'All';

  // Mock notifications
  final List<Map<String, dynamic>> _allNotifications = [
    {
      'id': 1,
      'type': 'payment',
      'title': 'Payment Received',
      'message': 'Sarah Nambi contributed UGX 75,000 to Tech Savers',
      'time': '2 hours ago',
      'isRead': false,
      'icon': Icons.payments_rounded,
      'color': Color(0xFF66BB6A),
    },
    {
      'id': 2,
      'type': 'risk',
      'title': 'High Risk Alert',
      'message': 'Peter Ssali has missed 3 consecutive payments',
      'time': '4 hours ago',
      'isRead': false,
      'icon': Icons.warning_rounded,
      'color': Color(0xFFEF5350),
    },
    {
      'id': 3,
      'type': 'cluster',
      'title': 'Cluster Milestone',
      'message': 'Business Builders reached 75% of savings goal!',
      'time': '1 day ago',
      'isRead': true,
      'icon': Icons.emoji_events_rounded,
      'color': Color(0xFFFF9800),
    },
    {
      'id': 4,
      'type': 'user',
      'title': 'New Member',
      'message': 'Mary Atim joined Future Leaders cluster',
      'time': '1 day ago',
      'isRead': true,
      'icon': Icons.person_add_rounded,
      'color': Color(0xFF4FC3F7),
    },
    {
      'id': 5,
      'type': 'system',
      'title': 'System Update',
      'message': 'New investment opportunities available for review',
      'time': '2 days ago',
      'isRead': true,
      'icon': Icons.info_rounded,
      'color': Color(0xFF9C27B0),
    },
    {
      'id': 6,
      'type': 'payment',
      'title': 'Withdrawal Request',
      'message': 'Grace Akello requested withdrawal of UGX 120,000',
      'time': '2 days ago',
      'isRead': false,
      'icon': Icons.account_balance_wallet_rounded,
      'color': Color(0xFF4FC3F7),
    },
    {
      'id': 7,
      'type': 'cluster',
      'title': 'Monthly Report Ready',
      'message': 'Tech Savers monthly performance report is available',
      'time': '3 days ago',
      'isRead': true,
      'icon': Icons.assessment_rounded,
      'color': Color(0xFF66BB6A),
    },
  ];

  List<Map<String, dynamic>> get _filteredNotifications {
    if (_selectedTab == 'All') {
      return _allNotifications;
    } else if (_selectedTab == 'Unread') {
      return _allNotifications.where((n) => !(n['isRead'] as bool)).toList();
    } else {
      return _allNotifications.where((n) => n['type'] == _selectedTab.toLowerCase()).toList();
    }
  }

  int get _unreadCount => _allNotifications.where((n) => !(n['isRead'] as bool)).length;

  @override
  Widget build(BuildContext context) {
    final notifications = _filteredNotifications;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Category Tabs
          _buildCategoryTabs(),

          // Notifications List
          Expanded(
            child: notifications.isEmpty
                ? _buildEmptyState()
                : _buildNotificationsList(notifications),
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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notifications',
            style: TextStyle(
              color: textDark,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          if (_unreadCount > 0)
            Text(
              '$_unreadCount unread',
              style: TextStyle(
                color: textLight,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
      actions: [
        if (_unreadCount > 0)
          TextButton(
            onPressed: () => _markAllAsRead(),
            child: const Text(
              'Mark all read',
              style: TextStyle(
                color: primaryBlue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    final categories = ['All', 'Unread', 'Payment', 'Risk', 'Cluster', 'User', 'System'];

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: softGray,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedTab == category;

          return GestureDetector(
            onTap: () => setState(() => _selectedTab = category),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? primaryBlue : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? primaryBlue : const Color(0xFFE2E8F0),
                ),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationsList(List<Map<String, dynamic>> notifications) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: notifications.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(notification);
      },
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    final isRead = notification['isRead'] as bool;

    return Dismissible(
      key: Key(notification['id'].toString()),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: dangerRed,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_rounded, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => _deleteNotification(notification),
      child: Container(
        decoration: BoxDecoration(
          color: isRead ? Colors.white : softGray,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isRead ? const Color(0xFFE2E8F0) : primaryBlue.withValues(alpha: 0.3),
            width: isRead ? 1 : 2,
          ),
        ),
        child: InkWell(
          onTap: () => _handleNotificationTap(notification),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (notification['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    notification['icon'] as IconData,
                    color: notification['color'] as Color,
                    size: 24,
                  ),
                ),

                const SizedBox(width: 16),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification['title'],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
                                color: textDark,
                              ),
                            ),
                          ),
                          if (!isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: primaryBlue,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        notification['message'],
                        style: TextStyle(
                          fontSize: 13,
                          color: textLight,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded, size: 14, color: textLight),
                          const SizedBox(width: 4),
                          Text(
                            notification['time'],
                            style: TextStyle(fontSize: 12, color: textLight),
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
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none_rounded, size: 80, color: textLight),
          const SizedBox(height: 16),
          const Text(
            'No notifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedTab == 'All'
                ? 'You\'re all caught up!'
                : 'No ${_selectedTab.toLowerCase()} notifications',
            style: TextStyle(fontSize: 14, color: textLight),
          ),
        ],
      ),
    );
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    setState(() {
      notification['isRead'] = true;
    });

    // Show action based on notification type
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Icon(
              notification['icon'] as IconData,
              color: notification['color'] as Color,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              notification['title'],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textDark,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              notification['message'],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: textLight,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Take Action',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Dismiss',
                  style: TextStyle(
                    color: textLight,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _allNotifications) {
        notification['isRead'] = true;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _deleteNotification(Map<String, dynamic> notification) {
    setState(() {
      _allNotifications.remove(notification);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notification deleted'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _allNotifications.add(notification);
            });
          },
        ),
      ),
    );
  }
}