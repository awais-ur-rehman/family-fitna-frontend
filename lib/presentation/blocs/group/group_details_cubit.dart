// File: lib/presentation/blocs/group/group_details_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/group_entity.dart';
import '../../../domain/repositories/group_repository.dart';

// State
abstract class GroupDetailsState extends Equatable {
  const GroupDetailsState();

  @override
  List<Object> get props => [];
}

class GroupDetailsInitial extends GroupDetailsState {}

class GroupDetailsLoading extends GroupDetailsState {}

class GroupDetailsLoaded extends GroupDetailsState {
  final GroupEntity group;
  final bool isAdmin;

  const GroupDetailsLoaded(this.group, this.isAdmin);

  @override
  List<Object> get props => [group, isAdmin];
}

class GroupDetailsError extends GroupDetailsState {
  final String message;

  const GroupDetailsError(this.message);

  @override
  List<Object> get props => [message];
}

// Cubit
class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  final GroupRepository repository;

  GroupDetailsCubit(this.repository) : super(GroupDetailsInitial());

  Future<void> loadGroupDetails(String groupId) async {
    emit(GroupDetailsLoading());
    try {
      final group = await repository.getGroupDetails(groupId);
      final isAdmin = group.role.toLowerCase() == 'admin';
      emit(GroupDetailsLoaded(group, isAdmin));
    } catch (e) {
      emit(GroupDetailsError(e.toString()));
    }
  }

  Future<void> refreshGroup(String groupId) async {
    if (state is GroupDetailsLoaded) {
      try {
        final group = await repository.getGroupDetails(groupId);
        final isAdmin = group.role.toLowerCase() == 'admin';
        emit(GroupDetailsLoaded(group, isAdmin));
      } catch (e) {
        // Keep the previous state on refresh error
      }
    }
  }
}