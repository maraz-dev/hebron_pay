part of 'bank_details_cubit.dart';

abstract class BankDetailsState extends Equatable {
  const BankDetailsState();

  @override
  List<Object> get props => [];
}

class BankDetailsInitial extends BankDetailsState {}

class BankDetailsLoading extends BankDetailsState {}

class BankDetailsSuccess extends BankDetailsState {}

class BankDetailsFailure extends BankDetailsState {
  final String errorMessage;

  const BankDetailsFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
