import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/home/domain/entity/bank_entity.dart';
import 'package:hebron_pay/features/home/domain/usecase/getbanks_usecase.dart';

part 'get_bank_state.dart';

class GetBankCubit extends Cubit<GetBankState> {
  final GetBanksUsecase usecase;
  GetBankCubit({required this.usecase}) : super(GetBankInitial());

  Future<List<BankEntity>?> getBanks() async {
    emit(GetBankLoading());
    try {
      var response = await usecase.call();
      emit(GetBankSuccess(availaibleBanks: response));
      return response;
    } on SocketException catch (e) {
      emit(GetBankFailure(errorMessage: e.message));
    } catch (e) {
      emit(GetBankFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
