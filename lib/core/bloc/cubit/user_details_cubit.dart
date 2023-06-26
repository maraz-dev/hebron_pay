import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/core/domain/user_entity.dart';
import 'package:hebron_pay/core/domain/user_usecases.dart';

part 'user_details_state.dart';

class UserDetailsCubit extends Cubit<UserDetailsState> {
  final UserUsecase userUsecase;
  final HebronPayWalletUsecase walletUsecase;
  final SubAccountUsecase subAccountUsecase;
  UserDetailsCubit({
    required this.userUsecase,
    required this.walletUsecase,
    required this.subAccountUsecase,
  }) : super(UserDetailsInitial());

  Future<UserEntity?> getUserDetails() async {
    emit(UserDetailsLoading());
    try {
      var userDetails = await userUsecase.call();
      emit(UserDetailsSuccess(userEntity: userDetails));
      return userDetails;
    } on SocketException catch (e) {
      emit(UserDetailsFailure(errorMessage: e.message));
    } catch (e) {
      emit(UserDetailsFailure(errorMessage: e.toString()));
    }
    return null;
  }

  Future<HebronPayWalletEntity?> getWalletDetails() async {
    emit(UserDetailsLoading());
    try {
      var walletDetails = await walletUsecase.call();
      emit(UserDetailsWalletSuccess(walletEntity: walletDetails));
      return walletDetails;
    } on SocketException catch (e) {
      emit(UserDetailsFailure(errorMessage: e.message));
    } catch (e) {
      emit(UserDetailsFailure(errorMessage: e.toString()));
    }
    return null;
  }

  Future<SubAccountEntity?> getSubAccoutDetails() async {
    emit(UserDetailsLoading());
    try {
      var subAccountDetails = await subAccountUsecase.call();
      emit(UserDetailsSubAccountSuccess(subAccountEntity: subAccountDetails));
      return subAccountDetails;
    } on SocketException catch (e) {
      emit(UserDetailsFailure(errorMessage: e.message));
    } catch (e) {
      emit(UserDetailsFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
