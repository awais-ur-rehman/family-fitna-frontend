import 'package:equatable/equatable.dart';

abstract class OtpVerificationState extends Equatable {
  const OtpVerificationState();

  @override
  List<Object?> get props => [];
}

class OtpVerificationInitial extends OtpVerificationState {}

class OtpVerificationLoading extends OtpVerificationState {}

class OtpVerificationSuccess extends OtpVerificationState {}

class OtpVerificationError extends OtpVerificationState {
  final String message;

  const OtpVerificationError(this.message);

  @override
  List<Object?> get props => [message];
}

class OtpResendLoading extends OtpVerificationState {}

class OtpResendSuccess extends OtpVerificationState {}

class OtpResendError extends OtpVerificationState {
  final String message;

  const OtpResendError(this.message);

  @override
  List<Object?> get props => [message];
}