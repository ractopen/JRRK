import 'package:flutter/material.dart';
import 'package:jrrk/core/eco_background.dart';
import 'package:jrrk/core/empty_box.dart';
import 'package:jrrk/core/custom_buttons.dart';

class AdminPortalScreen extends StatefulWidget {
  const AdminPortalScreen({super.key});

  @override
  State<AdminPortalScreen> createState() => _AdminPortalScreenState();
}

class _AdminPortalScreenState extends State<AdminPortalScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = const [
    AdminOverviewTab(),
    UserManagementTab(),
    ModerationTab(),
    AdminSettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoScanTheme.slateWhite,
      appBar: AppBar(
        title: const Text('Admin Portal', style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            onPressed: () => showPlaceholderDialog(context, 'Admin Alerts'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          IconButton(
            onPressed: () => logoutAndReturnToLogin(context),
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) => setState(() => _selectedIndex = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_rounded), label: 'Overview'),
          NavigationDestination(icon: Icon(Icons.group_rounded), label: 'Users'),
          NavigationDestination(icon: Icon(Icons.gpp_good_rounded), label: 'Moderation'),
          NavigationDestination(icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }
}

class AdminOverviewTab extends StatelessWidget {
  const AdminOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Operations Overview',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.45,
            children: [
              QuickActionCard(title: 'Active Users', icon: Icons.group_rounded, onTap: () => showPlaceholderDialog(context, 'Users Metric')),
              QuickActionCard(title: 'Reports', icon: Icons.report_problem_outlined, onTap: () => showPlaceholderDialog(context, 'Reports')),
              QuickActionCard(title: 'Risk Flags', icon: Icons.warning_amber_rounded, onTap: () => showPlaceholderDialog(context, 'Risk Flags')),
              QuickActionCard(title: 'Incidents', icon: Icons.layers_outlined, onTap: () => showPlaceholderDialog(context, 'Incident Queue')),
            ],
          ),
          const SizedBox(height: 20),
          const EmptyStatePanel(label: 'Admin dashboard metrics are ready for future live reporting'),
        ],
      ),
    );
  }
}

class UserManagementTab extends StatelessWidget {
  const UserManagementTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'User Management',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 14),
          UserManagementRow(name: 'Alicia Chen', role: 'Contributor', onPressed: () => showPlaceholderDialog(context, 'User Profile')),
          UserManagementRow(name: 'Mark Lopez', role: 'Reviewer', onPressed: () => showPlaceholderDialog(context, 'User Profile')),
          UserManagementRow(name: 'Nia Patel', role: 'Moderator', onPressed: () => showPlaceholderDialog(context, 'User Profile')),
          const SizedBox(height: 18),
          PrimaryButton(label: 'Invite New User', onPressed: () => showPlaceholderDialog(context, 'Invite Users')),
        ],
      ),
    );
  }
}

class ModerationTab extends StatelessWidget {
  const ModerationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Moderation Queue',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 14),
          ModerationItemCard(title: 'Report Review', description: '3 unresolved reports require attention.', onTap: () => showPlaceholderDialog(context, 'Report Review')),
          ModerationItemCard(title: 'Policy Check', description: 'One pending policy validation was flagged.', onTap: () => showPlaceholderDialog(context, 'Policy Check')),
          ModerationItemCard(title: 'Community Review', description: 'New content is waiting for moderator review.', onTap: () => showPlaceholderDialog(context, 'Community Review')),
        ],
      ),
    );
  }
}

class AdminSettingsTab extends StatelessWidget {
  const AdminSettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Admin Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 16),
          SettingsSectionTile(
            title: 'Role Permissions',
            icon: Icons.verified_user_rounded,
            subtitle: 'Adjust team access and guardrails',
            onTap: () => showPlaceholderDialog(context, 'Role Permissions'),
          ),
          SettingsSectionTile(
            title: 'Security Controls',
            icon: Icons.security_rounded,
            subtitle: 'Review authentication policies and audit logs',
            onTap: () => showPlaceholderDialog(context, 'Security Controls'),
          ),
          SettingsSectionTile(
            title: 'System Updates',
            icon: Icons.update_rounded,
            subtitle: 'Manage release notes and maintenance windows',
            onTap: () => showPlaceholderDialog(context, 'System Updates'),
          ),
        ],
      ),
    );
  }
}
