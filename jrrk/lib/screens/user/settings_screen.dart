import 'package:flutter/material.dart';
import 'package:jrrk/core/empty_box.dart';
import 'package:jrrk/core/eco_background.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Preferences',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: EcoScanTheme.charcoal,
                ),
              ),
              const SizedBox(height: 18),
              SettingsSectionTile(
                title: 'Account',
                icon: Icons.person_outline_rounded,
                subtitle: 'Manage your profile and security settings',
                onTap: () => showPlaceholderDialog(context, 'Account settings'),
              ),
              SettingsSectionTile(
                title: 'Notifications',
                icon: Icons.notifications_none_rounded,
                subtitle: 'Choose what updates you want to receive',
                onTap: () => showPlaceholderDialog(context, 'Notification settings'),
              ),
              SettingsSectionTile(
                title: 'Privacy',
                icon: Icons.lock_outline_rounded,
                subtitle: 'Review privacy options and data usage',
                onTap: () => showPlaceholderDialog(context, 'Privacy settings'),
              ),
              SettingsSectionTile(
                title: 'App Preferences',
                icon: Icons.tune_rounded,
                subtitle: 'Manage interface language and display',
                onTap: () => showPlaceholderDialog(context, 'App preferences'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
