import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/home/domain/usecase/fund_wallet_usecase.dart';

part 'fund_wallet_state.dart';

class FundWalletCubit extends Cubit<FundWalletState> {
  final FundWalletUsecase fundWalletUsecase;
  FundWalletCubit({required this.fundWalletUsecase})
      : super(FundWalletInitial());

  Future<String?> fundWallet(Map<String, dynamic> body) async {
    emit(FundWalletLoading());
    try {
      var successMessage = await fundWalletUsecase.call(body);
      emit(FundWalletSuccess());
    } on SocketException catch (e) {
      emit(FundWalletFailure(errorMessage: e.message));
    } catch (e) {
      emit(FundWalletFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
