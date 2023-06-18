part of 'balance_cubit.dart';

abstract class BalanceState extends Equatable {
  const BalanceState();

  @override
  List<Object> get props => [];
}

class BalanceInitial extends BalanceState {}

class BalanceSuccess extends BalanceState {}

class BalanceFailure extends BalanceState {
  final String errorMessage;

  const BalanceFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}

class BalanceLoading extends BalanceState {}
