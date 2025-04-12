// File: lib/presentation/blocs/group/create_group_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/group_entity.dart';
import '../../../domain/repositories/group_repository.dart';

// State
abstract class CreateGroupState extends Equatable {
  const CreateGroupState();

  @override
  List<Object> get props => [];
}

class CreateGroupInitial extends CreateGroupState {}

class CreateGroupLoading extends CreateGroupState {}

class CreateGroupSuccess extends CreateGroupState {
  final GroupEntity group;

  const CreateGroupSuccess(this.group);

  @override
  List<Object> get props => [group];
}

class CreateGroupError extends CreateGroupState {
  final String message;

  const CreateGroupError(this.message);

  @override
  List<Object> get props => [message];
}

// Cubit
class CreateGroupCubit extends Cubit<CreateGroupState> {
  final GroupRepository repository;

  CreateGroupCubit(this.repository) : super(CreateGroupInitial());

  Future<void> createGroup(String name, String? description) async {
    emit(CreateGroupLoading());
    try {
      final group = await repository.createGroup(name, description);
      emit(CreateGroupSuccess(group));
    } catch (e) {
      emit(CreateGroupError(e.toString()));
    }
  }

  void reset() {
    emit(CreateGroupInitial());
  }
}