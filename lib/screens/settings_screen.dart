import 'package:flutter/material.dart';

/// PIIC ClusterSave - Settings Screen
/// 
/// System-wide configuration and personalization
/// Features: App settings, account preferences, risk thresholds, support

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // PIIC Brand Colors
  static const Color primaryBlue = Color(0xFF4FC3F7);
  static const Color deepBlue = Color(0xFF0288D1);
  static const Color softGray = Color(0xFFF5F7FA);
  static const Color textDark = Color(0xFF2D3748);
  static const Color textLight = Color(0xFF718096);
  static const Color successGreen = Color(0xFF66BB6A);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color dangerRed = Color(0xFFEF5350);

  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _darkMode = false;
  bool _biometricAuth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            _buildProfileSection(),

            const SizedBox(height: 8),

            // General Settings
            _buildSectionHeader('General'),
            _buildSettingsGroup([
              _buildSettingTile(
                icon: Icons.language_rounded,
                title: 'Language',
                subtitle: 'English',
                onTap: () => _showLanguageDialog(),
              ),
              _buildSettingTile(
                icon: Icons.monetization_on_rounded,
                title: 'Currency',
                subtitle: 'UGX (Ugandan Shilling)',
                onTap: () => _showCurrencyDialog(),
              ),
              _buildSwitchTile(
                icon: Icons.dark_mode_rounded,
                title: 'Dark Mode',
                subtitle: 'Switch to dark theme',
                value: _darkMode,
                onChanged: (value) => setState(() => _darkMode = value),
              ),
            ]),

            const SizedBox(height: 24),

            // Notifications
            _buildSectionHeader('Notifications'),
            _buildSettingsGroup([
              _buildSwitchTile(
                icon: Icons.notifications_active_rounded,
                title: 'Push Notifications',
                subtitle: 'Receive push notifications',
                value: _pushNotifications,
                onChanged: (value) => setState(() => _pushNotifications = value),
              ),
              _buildSwitchTile(
                icon: Icons.email_rounded,
                title: 'Email Notifications',
                subtitle: 'Receive email alerts',
                value: _emailNotifications,
                onChanged: (value) => setState(() => _emailNotifications = value),
              ),
              _buildSwitchTile(
                icon: Icons.sms_rounded,
                title: 'SMS Notifications',
                subtitle: 'Receive SMS alerts',
                value: _smsNotifications,
                onChanged: (value) => setState(() => _smsNotifications = value),
              ),
            ]),

            const SizedBox(height: 24),

            // Security
            _buildSectionHeader('Security'),
            _buildSettingsGroup([
              _buildSwitchTile(
                icon: Icons.fingerprint_rounded,
                title: 'Biometric Authentication',
                subtitle: 'Use fingerprint or face ID',
                value: _biometricAuth,
                onChanged: (value) => setState(() => _biometricAuth = value),
              ),
              _buildSettingTile(
                icon: Icons.lock_reset_rounded,
                title: 'Change Password',
                subtitle: 'Update your password',
                onTap: () => _showChangePasswordDialog(),
              ),
              _buildSettingTile(
                icon: Icons.security_rounded,
                title: 'Two-Factor Authentication',
                subtitle: 'Add extra security',
                onTap: () => _show2FADialog(),
              ),
            ]),

            const SizedBox(height: 24),

            // Risk & Compliance
            _buildSectionHeader('Risk & Compliance'),
            _buildSettingsGroup([
              _buildSettingTile(
                icon: Icons.warning_rounded,
                title: 'Risk Thresholds',
                subtitle: 'Configure risk levels',
                onTap: () => _showRiskThresholdsDialog(),
              ),
              _buildSettingTile(
                icon: Icons.rule_rounded,
                title: 'Payment Rules',
                subtitle: 'Set payment policies',
                onTap: () => _showPaymentRulesDialog(),
              ),
            ]),

            const SizedBox(height: 24),

            // Data & Privacy
            _buildSectionHeader('Data & Privacy'),
            _buildSettingsGroup([
              _buildSettingTile(
                icon: Icons.backup_rounded,
                title: 'Backup Data',
                subtitle: 'Last backup: 2 days ago',
                onTap: () => _performBackup(),
              ),
              _buildSettingTile(
                icon: Icons.file_download_rounded,
                title: 'Export Data',
                subtitle: 'Download your data',
                onTap: () => _exportData(),
              ),
              _buildSettingTile(
                icon: Icons.privacy_tip_rounded,
                title: 'Privacy Policy',
                subtitle: 'View privacy policy',
                onTap: () => _showPrivacyPolicy(),
              ),
            ]),

            const SizedBox(height: 24),

            // Support
            _buildSectionHeader('Support'),
            _buildSettingsGroup([
              _buildSettingTile(
                icon: Icons.help_outline_rounded,
                title: 'Help Center',
                subtitle: 'Get help and support',
                onTap: () => _openHelpCenter(),
              ),
              _buildSettingTile(
                icon: Icons.feedback_rounded,
                title: 'Send Feedback',
                subtitle: 'Share your thoughts',
                onTap: () => _showFeedbackDialog(),
              ),
              _buildSettingTile(
                icon: Icons.info_outline_rounded,
                title: 'About',
                subtitle: 'Version 1.0.0',
                onTap: () => _showAboutDialog(),
              ),
            ]),

            const SizedBox(height: 24),

            // Danger Zone
            _buildSectionHeader('Danger Zone', color: dangerRed),
            _buildSettingsGroup([
              _buildSettingTile(
                icon: Icons.logout_rounded,
                title: 'Logout',
                subtitle: 'Sign out of your account',
                textColor: dangerRed,
                onTap: () => _confirmLogout(),
              ),
              _buildSettingTile(
                icon: Icons.delete_forever_rounded,
                title: 'Delete Account',
                subtitle: 'Permanently delete your account',
                textColor: dangerRed,
                onTap: () => _confirmDeleteAccount(),
              ),
            ]),

            const SizedBox(height: 32),

            // App Version
            Center(
              child: Column(
                children: [
                  Text(
                    'PIIC ClusterSave',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(fontSize: 12, color: textLight),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
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
        'Settings',
        style: TextStyle(
          color: textDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
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
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.person, color: primaryBlue, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Admin User',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'admin@piic.com',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_rounded, color: Colors.white),
            onPressed: () => _editProfile(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color ?? textDark,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: List.generate(
          children.length * 2 - 1,
          (index) {
            if (index.isOdd) {
              return const Divider(height: 1, indent: 68);
            }
            return children[index ~/ 2];
          },
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: (textColor ?? primaryBlue).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: textColor ?? primaryBlue, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: textColor ?? textDark,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 13, color: textLight),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: textColor ?? textLight,
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: primaryBlue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: primaryBlue, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: textDark,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 13, color: textLight),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: primaryBlue,
      ),
    );
  }

  // Dialog Methods
  void _editProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit Profile - Coming Soon'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showLanguageDialog() {
    _showSimpleDialog('Language', 'Language selection coming soon');
  }

  void _showCurrencyDialog() {
    _showSimpleDialog('Currency', 'Currency selection coming soon');
  }

  void _showChangePasswordDialog() {
    _showSimpleDialog('Change Password', 'Password change coming soon');
  }

  void _show2FADialog() {
    _showSimpleDialog('Two-Factor Auth', '2FA setup coming soon');
  }

  void _showRiskThresholdsDialog() {
    _showSimpleDialog('Risk Thresholds', 'Configure: High risk ≥ 2 missed OR ≥ 3 late payments');
  }

  void _showPaymentRulesDialog() {
    _showSimpleDialog('Payment Rules', 'Payment rules configuration coming soon');
  }

  void _performBackup() {
    _showSimpleDialog('Backup', 'Data backup initiated');
  }

  void _exportData() {
    _showSimpleDialog('Export Data', 'Data export coming soon');
  }

  void _showPrivacyPolicy() {
    _showSimpleDialog('Privacy Policy', 'Privacy policy will be displayed here');
  }

  void _openHelpCenter() {
    _showSimpleDialog('Help Center', 'Help center coming soon');
  }

  void _showFeedbackDialog() {
    _showSimpleDialog('Feedback', 'Feedback form coming soon');
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('About PIIC ClusterSave'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version 1.0.0'),
            SizedBox(height: 8),
            Text('Pooled Income Investment Club platform for collaborative savings and real estate investment.'),
          ],
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

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
            child: const Text('Logout', style: TextStyle(color: dangerRed)),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Account'),
        content: const Text('This action cannot be undone. All your data will be permanently deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account deletion - Coming Soon')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: dangerRed)),
          ),
        ],
      ),
    );
  }

  void _showSimpleDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}