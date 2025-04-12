// File: lib/presentation/screens/group/tabs/group_members_tab.dart

import 'package:flutter/material.dart';
import '../../../widgets/common/app_loading_indicator.dart';

class GroupMembersTab extends StatelessWidget {
  final String groupId;
  final bool isAdmin;

  const GroupMembersTab({
    Key? key,
    required this.groupId,
    required this.isAdmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLoadingIndicator(),
          SizedBox(height: 16),
          Text('Loading members...'),
        ],
      ),
    );
  }
}