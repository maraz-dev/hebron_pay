part of 'transaction_cubit.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionSuccess extends TransactionState {
  final List<TransactionEntity> userTrx;

  const TransactionSuccess({required this.userTrx});
}

class TransactionFailure extends TransactionState {
  final String errorMessage;

  const TransactionFailure({required this.errorMessage});
}
