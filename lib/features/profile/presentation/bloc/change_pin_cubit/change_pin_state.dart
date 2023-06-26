part of 'change_pin_cubit.dart';

abstract class ChangePinState extends Equatable {
  const ChangePinState();

  @override
  List<Object> get props => [];
}

class ChangePinInitial extends ChangePinState {}

class ChangePinLoading extends ChangePinState {}

class ChangePinSuccess extends ChangePinState {}

class ChangePinFailure extends ChangePinState {
  final String errorMessage;

  const ChangePinFailure({required this.errorMessage});
}
