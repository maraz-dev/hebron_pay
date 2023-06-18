part of 'generate_ticket_cubit.dart';

abstract class GenerateTicketState extends Equatable {
  const GenerateTicketState();

  @override
  List<Object> get props => [];
}

class GenerateTicketInitial extends GenerateTicketState {}

class GenerateTicketLoading extends GenerateTicketState {}

class GenerateTicketSuccess extends GenerateTicketState {}

class GenerateTicketFailure extends GenerateTicketState {
  final String errorMessage;

  const GenerateTicketFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
