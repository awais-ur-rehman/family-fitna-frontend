import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final AuthRepository _authRepository;

  OtpVerificationCubit(this._authRepository) : super(OtpVerificationInitial());

  Future<void> verifyOtp(String token) async {
    emit(OtpVerificationLoading());
    try {
      await _authRepository.verifyEmail(token);
      emit(OtpVerificationSuccess());
    } catch (e) {
      emit(OtpVerificationError(e.toString()));
    }
  }

  Future<void> resendOtp(String email) async {
    emit(OtpResendLoading());
    try {
      await _authRepository.forgotPassword(email);
      emit(OtpResendSuccess());
    } catch (e) {
      emit(OtpResendError(e.toString()));
    }
  }
}