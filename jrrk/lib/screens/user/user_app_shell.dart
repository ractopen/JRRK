import 'package:flutter/material.dart';
import 'package:jrrk/core/eco_background.dart';
import 'package:jrrk/core/empty_box.dart';
import 'package:jrrk/core/custom_buttons.dart';

class UserPortalScreen extends StatefulWidget {
  const UserPortalScreen({super.key});

  @override
  State<UserPortalScreen> createState() => _UserPortalScreenState();
}

class _UserPortalScreenState extends State<UserPortalScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = const [
    DashboardTab(),
    SearchTab(),
    CreateTab(),
    ActivityTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EcoScanTheme.slateWhite,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu_rounded, size: 28),
          ),
        ),
        title: const Text(
          'EcoScan+',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: EcoScanTheme.charcoal,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/chat'),
            icon: const Icon(Icons.chat_bubble_outline_rounded),
          ),
          IconButton(
            onPressed: () => showPlaceholderDialog(context, 'Notifications'),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: [
              Row(
                children: const [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: EcoScanTheme.peach,
                    child: Icon(Icons.person_rounded, color: EcoScanTheme.charcoal),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Profile',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: EcoScanTheme.charcoal,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'user@ecoscan.app',
                          style: TextStyle(color: EcoScanTheme.slate, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ...[
                'Dashboard',
                'Chat Support',
                'Activity',
                'History',
                'Analytics',
                'Settings',
                'Log Out',
              ].map(
                (item) => ListTile(
                  title: Text(item),
                  onTap: () {
                    Navigator.pop(context);
                    switch (item) {
                      case 'Dashboard':
                        setState(() => _selectedIndex = 0);
                        break;
                      case 'Chat Support':
                        Navigator.pushNamed(context, '/chat');
                        break;
                      case 'Activity':
                        setState(() => _selectedIndex = 3);
                        break;
                      case 'History':
                        Navigator.pushNamed(context, '/history');
                        break;
                      case 'Analytics':
                        Navigator.pushNamed(context, '/analytics');
                        break;
                      case 'Settings':
                        Navigator.pushNamed(context, '/settings');
                        break;
                      case 'Log Out':
                        logoutAndReturnToLogin(context);
                        break;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _tabs),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) => setState(() => _selectedIndex = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search_rounded), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.add_circle_outline_rounded), label: 'Create'),
          NavigationDestination(icon: Icon(Icons.notifications_none_rounded), label: 'Activity'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [EcoScanTheme.peach, EcoScanTheme.mistTeal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome back, user@example.com',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: EcoScanTheme.charcoal,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your next eco opportunity is ready to be organized and explored.',
                  style: TextStyle(color: EcoScanTheme.slate, fontSize: 14, height: 1.6),
                ),
                const SizedBox(height: 18),
                PrimaryButton(
                  label: 'Scan Now',
                  onPressed: () => showPlaceholderDialog(context, 'Quick Scan Flow'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
            children: [
              QuickActionCard(title: 'Entry', icon: Icons.add_rounded, onTap: () => showPlaceholderDialog(context, 'New Entry')),
              QuickActionCard(title: 'Insights', icon: Icons.insights_rounded, onTap: () => Navigator.pushNamed(context, '/analytics')),
              QuickActionCard(title: 'History', icon: Icons.history_rounded, onTap: () => Navigator.pushNamed(context, '/history')),
              QuickActionCard(title: 'Support', icon: Icons.support_agent_rounded, onTap: () => Navigator.pushNamed(context, '/chat')),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Recent Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 10),
          const EmptyStatePanel(label: 'Overview panel ready for future integration'),
        ],
      ),
    );
  }
}

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search items, records or actions',
              prefixIcon: const Icon(Icons.search_rounded, color: EcoScanTheme.slate),
              suffixIcon: IconButton(
                onPressed: () => showPlaceholderDialog(context, 'Search Reset'),
                icon: const Icon(Icons.close_rounded, color: EcoScanTheme.slate),
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Search results',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 12),
          const EmptyStatePanel(label: 'Search result placeholder waiting for live index data'),
        ],
      ),
    );
  }
}

class CreateTab extends StatelessWidget {
  const CreateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create / Add Entry',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: EcoScanTheme.border),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'New Record',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: EcoScanTheme.charcoal,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Use this workflow to create a structured item when your data model is connected.',
                  style: TextStyle(color: EcoScanTheme.slate, fontSize: 14),
                ),
                const SizedBox(height: 18),
                PrimaryButton(
                  label: 'Add New Record',
                  onPressed: () => showPlaceholderDialog(context, 'Create Entry Modal'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityTab extends StatelessWidget {
  const ActivityTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Activity & Notifications',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                FilterChipOption(label: 'All', selected: true),
                FilterChipOption(label: 'Category 1'),
                FilterChipOption(label: 'Category 2'),
                FilterChipOption(label: 'Category 3'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ActivityListItem(
            username: 'Alicia Chen',
            time: '2 min ago',
            message: 'Shared a new review on the latest update.',
            unread: true,
            onPressed: () => showPlaceholderDialog(context, 'Activity Detail'),
          ),
          ActivityListItem(
            username: 'Mark Lopez',
            time: '1 hour ago',
            message: 'Uploaded a new project snapshot for review.',
            unread: false,
            onPressed: () => showPlaceholderDialog(context, 'Activity Detail'),
          ),
          ActivityListItem(
            username: 'Nia Patel',
            time: 'Today',
            message: 'Commented on a new entry from the team queue.',
            unread: true,
            onPressed: () => showPlaceholderDialog(context, 'Activity Detail'),
          ),
        ],
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 46,
                backgroundColor: EcoScanTheme.mistTeal,
                child: Icon(Icons.person_rounded, size: 42, color: EcoScanTheme.charcoal),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: EcoScanTheme.charcoal,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit_rounded, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'user@ecoscan.app',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: EcoScanTheme.charcoal,
            ),
          ),
          const SizedBox(height: 18),
          const EmptyStatePanel(label: 'Profile summary placeholder ready for connected metrics'),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: EcoScanTheme.border),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ProfileQuickLink(title: 'Account', icon: Icons.person_outline_rounded, onTap: () => showPlaceholderDialog(context, 'Account Settings')),
                ProfileQuickLink(title: 'Privacy & Security', icon: Icons.lock_outline_rounded, onTap: () => showPlaceholderDialog(context, 'Privacy & Security')),
                ProfileQuickLink(title: 'Notifications', icon: Icons.notifications_none_rounded, onTap: () => showPlaceholderDialog(context, 'Notifications')),
                ProfileQuickLink(title: 'Theme', icon: Icons.dark_mode_outlined, onTap: () => showPlaceholderDialog(context, 'Theme Settings')),
                ProfileQuickLink(title: 'About', icon: Icons.info_outline_rounded, onTap: () => showPlaceholderDialog(context, 'About')),
                ProfileQuickLink(title: 'Log Out', icon: Icons.logout_rounded, onTap: () => logoutAndReturnToLogin(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
