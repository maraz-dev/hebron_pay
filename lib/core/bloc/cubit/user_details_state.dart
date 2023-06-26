part of 'user_details_cubit.dart';

abstract class UserDetailsState extends Equatable {
  const UserDetailsState();

  @override
  List<Object> get props => [];
}

class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class UserDetailsFailure extends UserDetailsState {
  final String errorMessage;

  const UserDetailsFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}

class UserDetailsSuccess extends UserDetailsState {
  final UserEntity userEntity;

  const UserDetailsSuccess({required this.userEntity});

  @override
  List<Object> get props => [userEntity];
}

class UserDetailsWalletSuccess extends UserDetailsState {
  final HebronPayWalletEntity walletEntity;

  const UserDetailsWalletSuccess({required this.walletEntity});

  @override
  List<Object> get props => [walletEntity];
}

class UserDetailsSubAccountSuccess extends UserDetailsState {
  final SubAccountEntity subAccountEntity;

  const UserDetailsSubAccountSuccess({required this.subAccountEntity});

  @override
  List<Object> get props => [subAccountEntity];
}
