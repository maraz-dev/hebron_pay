part of 'confirm_payment_cubit.dart';

abstract class ConfirmPaymentState extends Equatable {
  const ConfirmPaymentState();

  @override
  List<Object> get props => [];
}

class ConfirmPaymentInitial extends ConfirmPaymentState {}

class ConfirmPaymentLoading extends ConfirmPaymentState {}

class ConfirmPaymentSuccess extends ConfirmPaymentState {}

class ConfirmPaymentFailure extends ConfirmPaymentState {
  final String errorMessage;

  const ConfirmPaymentFailure({required this.errorMessage});
}
