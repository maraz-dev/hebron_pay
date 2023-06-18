part of 'fund_wallet_cubit.dart';

abstract class FundWalletState extends Equatable {
  const FundWalletState();

  @override
  List<Object> get props => [];
}

class FundWalletInitial extends FundWalletState {}

class FundWalletSuccess extends FundWalletState {}

class FundWalletFailure extends FundWalletState {
  final String errorMessage;

  const FundWalletFailure({required this.errorMessage});
}

class FundWalletLoading extends FundWalletState {}
