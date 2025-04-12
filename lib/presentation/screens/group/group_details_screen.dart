// File: lib/presentation/screens/group/group_details_screen.dart

import 'package:family_fitna/presentation/screens/group/tabs/group_leaderboard_tab.dart';
import 'package:family_fitna/presentation/screens/group/tabs/group_members_tab.dart';
import 'package:family_fitna/presentation/screens/group/tabs/group_posts_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/group/group_details_cubit.dart';
import '../../widgets/common/app_loading_indicator.dart';
import '../../widgets/common/app_error_view.dart';
import '../../../config/routes.dart';
import '../../../domain/repositories/group_repository.dart';
import '../../widgets/group/group_header_widget.dart';

class GroupDetailsScreen extends StatefulWidget {
  final String groupId;
  final int initialTab;

  const GroupDetailsScreen({
    Key? key,
    required this.groupId,
    this.initialTab = 0,
  }) : super(key: key);

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late GroupDetailsCubit _groupDetailsCubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTab,
    );

    // Create the cubit and load group details
    _groupDetailsCubit = GroupDetailsCubit(context.read<GroupRepository>());
    _groupDetailsCubit.loadGroupDetails(widget.groupId);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _groupDetailsCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _groupDetailsCubit,
      child: BlocBuilder<GroupDetailsCubit, GroupDetailsState>(
        builder: (context, state) {
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    title: Text(
                      state is GroupDetailsLoaded
                          ? state.group.name
                          : 'Group Details',
                    ),
                    pinned: true,
                    floating: true,
                    actions: [
                      if (state is GroupDetailsLoaded && state.isAdmin)
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '${AppRouter.groupDetails}/settings',
                              arguments: {'groupId': widget.groupId},
                            );
                          },
                        ),
                    ],
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'Posts'),
                        Tab(text: 'Members'),
                        Tab(text: 'Leaderboard'),
                      ],
                    ),
                  ),
                  if (state is GroupDetailsLoaded)
                    SliverToBoxAdapter(
                      child: GroupHeaderWidget(
                        group: state.group,
                        isAdmin: state.isAdmin,
                      ),
                    ),
                ];
              },
              body: state is GroupDetailsLoading
                  ? const Center(child: AppLoadingIndicator())
                  : state is GroupDetailsError
                  ? AppErrorView(
                message: state.message,
                onRetry: () => _groupDetailsCubit.loadGroupDetails(widget.groupId),
              )
                  : state is GroupDetailsLoaded
                  ? TabBarView(
                controller: _tabController,
                children: [
                  GroupPostsTab(groupId: widget.groupId),
                  GroupMembersTab(
                    groupId: widget.groupId,
                    isAdmin: state.isAdmin,
                  ),
                  GroupLeaderboardTab(groupId: widget.groupId),
                ],
              )
                  : const SizedBox.shrink(),
            ),
            floatingActionButton: state is GroupDetailsLoaded && _tabController.index == 0
                ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '${AppRouter.groupDetails}/create-post',
                  arguments: {'groupId': widget.groupId},
                );
              },
              tooltip: 'Create a new post',
              child: const Icon(Icons.add),
            )
                : null,
          );
        },
      ),
    );
  }
}