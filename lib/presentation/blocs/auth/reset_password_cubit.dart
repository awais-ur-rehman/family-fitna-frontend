import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';

// States
abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class ResetPasswordLoading extends ResetPasswordState {}

class ResetPasswordSuccess extends ResetPasswordState {}

class ResetPasswordError extends ResetPasswordState {
  final String message;

  const ResetPasswordError(this.message);

  @override
  List<Object?> get props => [message];
}

// Cubit
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository _authRepository;

  ResetPasswordCubit(this._authRepository) : super(ResetPasswordInitial());

  Future<void> resetPassword(String token, String password) async {
    emit(ResetPasswordLoading());
    try {
      await _authRepository.resetPassword(token, password);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordError(e.toString()));
    }
  }
}