part of 'set_pin_cubit.dart';

abstract class SetPinState extends Equatable {
  const SetPinState();

  @override
  List<Object> get props => [];
}

class SetPinInitial extends SetPinState {}

class SetPinLoading extends SetPinState {}

class SetPinSuccess extends SetPinState {}

class SetPinFailure extends SetPinState {
  final String errorMessage;

  const SetPinFailure({required this.errorMessage});
}
