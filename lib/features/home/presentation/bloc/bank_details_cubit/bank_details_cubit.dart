// ignore_for_file: unused_import

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/home/domain/entity/account_details_entity.dart';
import 'package:hebron_pay/features/home/domain/entity/bank_entity.dart';
import 'package:hebron_pay/features/home/domain/usecase/getbanks_usecase.dart';
import 'package:hebron_pay/features/home/domain/usecase/resolve_acct_details_usecase.dart';

part 'bank_details_state.dart';

class BankDetailsCubit extends Cubit<BankDetailsState> {
  final ResolveAcctDetailsUsecase usecase;
  BankDetailsCubit({required this.usecase}) : super(BankDetailsInitial());

  Future<AccountDetailsEntity?> getAccountDetails(
      Map<String, dynamic> body) async {
    emit(BankDetailsLoading());
    try {
      var response = await usecase.call(body);
      emit(BankDetailsSuccess());
      return response;
    } on SocketException catch (e) {
      emit(BankDetailsFailure(errorMessage: e.message));
    } catch (e) {
      emit(BankDetailsFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
