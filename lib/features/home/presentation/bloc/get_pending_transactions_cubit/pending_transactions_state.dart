part of 'pending_transactions_cubit.dart';

abstract class PendingTransactionsState extends Equatable {
  const PendingTransactionsState();

  @override
  List<Object> get props => [];
}

class PendingTransactionsInitial extends PendingTransactionsState {}

class PendingTransactionsLoading extends PendingTransactionsState {}

class PendingTransactionsSuccess extends PendingTransactionsState {
  final List<PendingTransactionEntity> pendingTrx;

  const PendingTransactionsSuccess({required this.pendingTrx});
}

class PendingTransactionsFailure extends PendingTransactionsState {
  final String errorMessage;

  const PendingTransactionsFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
