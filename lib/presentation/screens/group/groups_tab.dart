// File: lib/presentation/screens/group/groups_tab.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/group/group_list_cubit.dart';
import '../../widgets/group/group_card.dart';
import '../../widgets/common/app_error_view.dart';
import '../../widgets/common/app_loading_indicator.dart';
import '../../widgets/common/app_empty_state_view.dart';
import '../../../config/routes.dart';

class GroupsTab extends StatefulWidget {
  const GroupsTab({Key? key}) : super(key: key);

  @override
  State<GroupsTab> createState() => _GroupsTabState();
}

class _GroupsTabState extends State<GroupsTab> {
  @override
  void initState() {
    super.initState();
    context.read<GroupListCubit>().loadGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groups'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => Navigator.pushNamed(context, AppRouter.joinGroup),
            tooltip: 'Join a group',
          ),
        ],
      ),
      body: BlocBuilder<GroupListCubit, GroupListState>(
        builder: (context, state) {
          if (state is GroupListLoading) {
            return const Center(
              child: AppLoadingIndicator(),
            );
          } else if (state is GroupListError) {
            return AppErrorView(
              message: state.message,
              onRetry: () => context.read<GroupListCubit>().loadGroups(),
            );
          } else if (state is GroupListLoaded) {
            if (state.groups.isEmpty) {
              return AppEmptyStateView(
                message: 'You haven\'t joined any groups yet',
                actionText: 'Create a Group',
                onAction: () => Navigator.pushNamed(context, AppRouter.createGroup),
                icon: Icons.group,
              );
            }

            return RefreshIndicator(
              onRefresh: () => context.read<GroupListCubit>().refreshGroups(),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 80),
                itemCount: state.groups.length,
                itemBuilder: (context, index) {
                  final group = state.groups[index];
                  return GroupCard(
                    group: group,
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRouter.groupDetails,
                      arguments: {
                        'groupId': group.id,
                      },
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AppRouter.createGroup),
        tooltip: 'Create a new group',
        child: const Icon(Icons.add),
      ),
    );
  }
}