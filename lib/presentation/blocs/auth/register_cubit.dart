import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterCubit(this._authRepository) : super(RegisterInitial());

  Future<void> register(String name, String email, String password) async {
    emit(RegisterLoading());
    try {
      final user = await _authRepository.register(name, email, password);
      emit(RegisterSuccess(user));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}