part of 'sign_up_cubit_cubit.dart';

abstract class SignUpCubitState extends Equatable {
  const SignUpCubitState();

  @override
  List<Object> get props => [];
}

class SignUpCubitInitial extends SignUpCubitState {
  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpCubitState {
  @override
  List<Object> get props => [];
}

class SignUpFailure extends SignUpCubitState {
  final String errorMessage;

  const SignUpFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class SignUpSuccess extends SignUpCubitState {
  @override
  List<Object> get props => [];
}
