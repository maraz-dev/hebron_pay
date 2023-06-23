part of 'delete_ticket_cubit.dart';

abstract class DeleteTicketState extends Equatable {
  const DeleteTicketState();

  @override
  List<Object> get props => [];
}

class DeleteTicketInitial extends DeleteTicketState {}

class DeleteTicketLoading extends DeleteTicketState {}

class DeleteTicketSuccess extends DeleteTicketState {}

class DeleteTicketFailure extends DeleteTicketState {
  final String errorMessage;

  const DeleteTicketFailure({required this.errorMessage});
}
