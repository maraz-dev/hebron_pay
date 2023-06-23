part of 'get_bank_cubit.dart';

abstract class GetBankState extends Equatable {
  const GetBankState();

  @override
  List<Object> get props => [];
}

class GetBankInitial extends GetBankState {}

class GetBankLoading extends GetBankState {}

class GetBankSuccess extends GetBankState {
  final List<BankEntity> availaibleBanks;

  const GetBankSuccess({required this.availaibleBanks});
}

class GetBankFailure extends GetBankState {
  final String errorMessage;

  const GetBankFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}
