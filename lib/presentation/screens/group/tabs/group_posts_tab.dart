// File: lib/presentation/screens/group/tabs/group_posts_tab.dart

import 'package:flutter/material.dart';
import '../../../widgets/common/app_empty_state_view.dart';

class GroupPostsTab extends StatelessWidget {
  final String groupId;

  const GroupPostsTab({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppEmptyStateView(
      message: 'No posts in this group yet',
      actionText: 'Create First Post',
      onAction: () {
        // Navigate to create post screen
      },
      icon: Icons.post_add,
    );
  }
}