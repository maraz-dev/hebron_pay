part of 'withdraw_cubit.dart';

abstract class WithdrawState extends Equatable {
  const WithdrawState();

  @override
  List<Object> get props => [];
}

class WithdrawInitial extends WithdrawState {}

class WithdrawLoading extends WithdrawState {}

class WithdrawSuccess extends WithdrawState {}

class WithdrawFailure extends WithdrawState {
  final String errorMessage;

  const WithdrawFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
