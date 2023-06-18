import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/home/domain/usecase/generate_ticket_usecase.dart';

part 'generate_ticket_state.dart';

class GenerateTicketCubit extends Cubit<GenerateTicketState> {
  final GenerateTicketUsecase usecase;
  GenerateTicketCubit({required this.usecase}) : super(GenerateTicketInitial());

  Future<String?> generateTicket(Map<String, dynamic> body) async {
    emit(GenerateTicketLoading());
    try {
      var successMessage = await usecase.call(body);
      emit(GenerateTicketSuccess());
      return successMessage;
    } on SocketException catch (e) {
      emit(GenerateTicketFailure(errorMessage: e.message));
    } catch (e) {
      emit(GenerateTicketFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
