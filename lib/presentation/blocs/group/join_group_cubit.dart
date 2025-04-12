// File: lib/presentation/blocs/group/join_group_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/group_entity.dart';
import '../../../domain/repositories/group_repository.dart';

// State
abstract class JoinGroupState extends Equatable {
  const JoinGroupState();

  @override
  List<Object> get props => [];
}

class JoinGroupInitial extends JoinGroupState {}

class JoinGroupLoading extends JoinGroupState {}

class JoinGroupSuccess extends JoinGroupState {
  final GroupEntity group;

  const JoinGroupSuccess(this.group);

  @override
  List<Object> get props => [group];
}

class JoinGroupError extends JoinGroupState {
  final String message;

  const JoinGroupError(this.message);

  @override
  List<Object> get props => [message];
}

// Cubit
class JoinGroupCubit extends Cubit<JoinGroupState> {
  final GroupRepository repository;

  JoinGroupCubit(this.repository) : super(JoinGroupInitial());

  Future<void> joinGroup(String joinCode) async {
    emit(JoinGroupLoading());
    try {
      final group = await repository.joinGroup(joinCode);
      emit(JoinGroupSuccess(group));
    } catch (e) {
      emit(JoinGroupError(e.toString()));
    }
  }

  void reset() {
    emit(JoinGroupInitial());
  }
}