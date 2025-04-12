// File: lib/presentation/widgets/group/group_header_widget.dart

import 'package:flutter/material.dart';
import '../../../domain/entities/group_entity.dart';

class GroupHeaderWidget extends StatelessWidget {
  final GroupEntity group;
  final bool isAdmin;
  final VoidCallback? onSettingsTap;

  const GroupHeaderWidget({
    Key? key,
    required this.group,
    required this.isAdmin,
    this.onSettingsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      color: theme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (group.description != null && group.description!.isNotEmpty) ...[
            Text(
              'About this group',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              group.description!,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
          ],
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.people, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${group.memberCount} members',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.admin_panel_settings,
                    size: 16,
                    color: isAdmin ? theme.primaryColor : Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Your role: ${group.role}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: isAdmin ? FontWeight.bold : FontWeight.normal,
                      color: isAdmin ? theme.primaryColor : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 32),
        ],
      ),
    );
  }
}