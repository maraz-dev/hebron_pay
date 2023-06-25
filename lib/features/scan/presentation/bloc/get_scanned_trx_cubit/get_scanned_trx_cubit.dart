import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/scan/domain/entities/get_transaction_entity.dart';
import 'package:hebron_pay/features/scan/domain/usecase/get_trx_usecase.dart';

part 'get_scanned_trx_state.dart';

class GetScannedTrxCubit extends Cubit<GetScannedTrxState> {
  final GetTrxUsecase usecase;
  GetScannedTrxCubit({required this.usecase}) : super(GetScannedTrxInitial());

  Future<GetTrxEntity?> getScannedDetails(String reference) async {
    emit(GetScannedTrxLoading());
    try {
      var gottenScannedDetails = await usecase.call(reference);
      emit(GetScannedTrxSucccess(scannedDetails: gottenScannedDetails));
      return gottenScannedDetails;
    } on SocketException catch (e) {
      emit(GetScannedTrxFailure(errorMessage: e.message));
    } catch (e) {
      emit(GetScannedTrxFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
