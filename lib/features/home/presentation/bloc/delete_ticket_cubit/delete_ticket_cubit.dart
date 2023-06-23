import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/home/domain/usecase/delete_ticket_usecase.dart';

part 'delete_ticket_state.dart';

class DeleteTicketCubit extends Cubit<DeleteTicketState> {
  final DeleteTicketUsecase usecase;
  DeleteTicketCubit({required this.usecase}) : super(DeleteTicketInitial());

  Future<String?> deleteTicket(String reference) async {
    emit(DeleteTicketLoading());
    try {
      var successMessage = await usecase.call(reference);
      return successMessage;
    } on SocketException catch (e) {
      emit(DeleteTicketFailure(errorMessage: e.message));
    } catch (e) {
      emit(DeleteTicketFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
