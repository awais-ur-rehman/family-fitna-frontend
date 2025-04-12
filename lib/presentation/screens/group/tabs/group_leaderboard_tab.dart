// File: lib/presentation/screens/group/tabs/group_leaderboard_tab.dart

import 'package:flutter/material.dart';
import '../../../widgets/common/app_loading_indicator.dart';

class GroupLeaderboardTab extends StatelessWidget {
  final String groupId;

  const GroupLeaderboardTab({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLoadingIndicator(),
          SizedBox(height: 16),
          Text('Loading leaderboard...'),
        ],
      ),
    );
  }
}