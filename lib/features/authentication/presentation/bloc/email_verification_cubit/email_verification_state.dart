part of 'email_verification_cubit.dart';

abstract class EmailVerificationState extends Equatable {
  const EmailVerificationState();

  @override
  List<Object> get props => [];
}

class EmailVerificationInitial extends EmailVerificationState {
  @override
  List<Object> get props => [];
}

class EmailVerificationLoading extends EmailVerificationState {
  @override
  List<Object> get props => [];
}

class EmailVerificationSuccess extends EmailVerificationState {
  @override
  List<Object> get props => [];
}

class EmailVerificationSent extends EmailVerificationState {
  @override
  List<Object> get props => [];
}

class EmailVerificationFailed extends EmailVerificationState {
  final String errorMessage;

  const EmailVerificationFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
