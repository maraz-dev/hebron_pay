part of 'get_scanned_trx_cubit.dart';

abstract class GetScannedTrxState extends Equatable {
  const GetScannedTrxState();

  @override
  List<Object> get props => [];
}

class GetScannedTrxInitial extends GetScannedTrxState {}

class GetScannedTrxLoading extends GetScannedTrxState {}

class GetScannedTrxFailure extends GetScannedTrxState {
  final String errorMessage;

  const GetScannedTrxFailure({required this.errorMessage});
}

class GetScannedTrxSucccess extends GetScannedTrxState {
  final GetTrxEntity scannedDetails;

  const GetScannedTrxSucccess({required this.scannedDetails});
}
