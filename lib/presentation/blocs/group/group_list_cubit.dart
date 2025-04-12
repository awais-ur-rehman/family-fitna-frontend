// File: lib/presentation/blocs/group/group_list_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/group_entity.dart';
import '../../../domain/repositories/group_repository.dart';

// State
abstract class GroupListState extends Equatable {
  const GroupListState();

  @override
  List<Object> get props => [];
}

class GroupListInitial extends GroupListState {}

class GroupListLoading extends GroupListState {}

class GroupListLoaded extends GroupListState {
  final List<GroupEntity> groups;

  const GroupListLoaded(this.groups);

  @override
  List<Object> get props => [groups];
}

class GroupListError extends GroupListState {
  final String message;

  const GroupListError(this.message);

  @override
  List<Object> get props => [message];
}

// Cubit
class GroupListCubit extends Cubit<GroupListState> {
  final GroupRepository repository;

  GroupListCubit(this.repository) : super(GroupListInitial());

  Future<void> loadGroups() async {
    emit(GroupListLoading());
    try {
      final groups = await repository.getGroups();
      emit(GroupListLoaded(groups));
    } catch (e) {
      emit(GroupListError(e.toString()));
    }
  }

  Future<void> refreshGroups() async {
    try {
      final groups = await repository.getGroups();
      emit(GroupListLoaded(groups));
    } catch (e) {
      emit(GroupListError(e.toString()));
    }
  }
}