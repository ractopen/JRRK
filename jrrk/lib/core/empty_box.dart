import 'package:flutter/material.dart';
import 'package:jrrk/core/eco_background.dart';

class EmptyStatePanel extends StatelessWidget {
  const EmptyStatePanel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: EcoScanTheme.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: EcoScanTheme.slate,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: EcoScanTheme.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: EcoScanTheme.peach,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: EcoScanTheme.charcoal),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: EcoScanTheme.charcoal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityListItem extends StatelessWidget {
  const ActivityListItem({
    super.key,
    required this.username,
    required this.time,
    required this.message,
    required this.unread,
    required this.onPressed,
  });

  final String username;
  final String time;
  final String message;
  final bool unread;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: EcoScanTheme.border)),
        ),
        child: Row(
          children: [
            if (unread)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              ),
            const CircleAvatar(
              radius: 20,
              backgroundColor: EcoScanTheme.mistTeal,
              child: Icon(Icons.person_rounded, size: 18, color: EcoScanTheme.charcoal),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: EcoScanTheme.charcoal,
                        ),
                      ),
                      Text(time, style: const TextStyle(fontSize: 11, color: EcoScanTheme.slate)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(message, style: const TextStyle(fontSize: 13, color: EcoScanTheme.slate)),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: EcoScanTheme.slateWhite,
                border: Border.all(color: EcoScanTheme.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.chevron_right_rounded, color: EcoScanTheme.slate),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterChipOption extends StatelessWidget {
  const FilterChipOption({super.key, required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => showPlaceholderDialog(context, '$label filter'),
        backgroundColor: Colors.white,
        selectedColor: EcoScanTheme.charcoal,
        labelStyle: TextStyle(
          color: selected ? Colors.white : EcoScanTheme.charcoal,
          fontWeight: FontWeight.w600,
        ),
        side: const BorderSide(color: EcoScanTheme.border),
      ),
    );
  }
}

class ProfileQuickLink extends StatelessWidget {
  const ProfileQuickLink({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: EcoScanTheme.charcoal),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: EcoScanTheme.charcoal,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: EcoScanTheme.slate),
          ],
        ),
      ),
    );
  }
}

class SettingsSectionTile extends StatelessWidget {
  const SettingsSectionTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: EcoScanTheme.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: EcoScanTheme.charcoal),
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle!),
        trailing: const Icon(Icons.chevron_right_rounded, color: EcoScanTheme.slate),
        onTap: onTap,
      ),
    );
  }
}

class UserManagementRow extends StatelessWidget {
  const UserManagementRow({
    super.key,
    required this.name,
    this.email,
    required this.role,
    this.onPressed,
    this.onToggle,
    this.onEdit,
  });

  final String name;
  final String? email;
  final String role;
  final VoidCallback? onPressed;
  final VoidCallback? onToggle;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final rowAction = onPressed ?? onEdit ?? () {};

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: EcoScanTheme.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundColor: EcoScanTheme.mistTeal,
            child: Icon(Icons.person_rounded, color: EcoScanTheme.charcoal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: EcoScanTheme.charcoal,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: EcoScanTheme.cream,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        role,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: EcoScanTheme.charcoal,
                        ),
                      ),
                    ),
                  ],
                ),
                if (email != null && email!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(email!, style: const TextStyle(fontSize: 12, color: EcoScanTheme.slate)),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (onToggle != null) ...[
            Switch.adaptive(value: true, onChanged: (_) => onToggle!.call()),
            const SizedBox(width: 4),
          ],
          IconButton(onPressed: rowAction, icon: const Icon(Icons.edit_rounded)),
        ],
      ),
    );
  }
}

class ModerationItemCard extends StatelessWidget {
  const ModerationItemCard({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
    this.onApprove,
    this.onReject,
  });

  final String title;
  final String description;
  final VoidCallback? onTap;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
    final hasActions = onApprove != null || onReject != null;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: EcoScanTheme.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: EcoScanTheme.charcoal,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(color: EcoScanTheme.slate, fontSize: 13),
            ),
            if (hasActions) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onApprove ?? () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: EcoScanTheme.charcoal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Approve'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onReject ?? () {},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Reject'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
