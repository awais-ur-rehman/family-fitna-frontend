// File: lib/presentation/widgets/group/group_card.dart

import 'package:flutter/material.dart';
import '../../../domain/entities/group_entity.dart';
import '../../../config/theme.dart';

class GroupCard extends StatelessWidget {
  final GroupEntity group;
  final VoidCallback onTap;

  const GroupCard({
    Key? key,
    required this.group,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                group.name,
                style: theme.textTheme.displayMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (group.description != null && group.description!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    group.description!,
                    style: theme.textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              const SizedBox(height: 16),
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
                  Text(
                    'Your role: ${group.role}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: group.role.toLowerCase() == 'admin'
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}