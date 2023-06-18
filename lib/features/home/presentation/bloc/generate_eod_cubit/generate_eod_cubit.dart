import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hebron_pay/features/home/domain/usecase/generate_eod_usecase.dart';

part 'generate_eod_state.dart';

class GenerateEodCubit extends Cubit<GenerateEodState> {
  final GenerateEodUsecase usecase;
  GenerateEodCubit({required this.usecase}) : super(GenerateEodInitial());

  Future<String?> generateEod() async {
    emit(GenerateEodLoading());
    try {
      var successMessage = await usecase.call();
      emit(GenerateEodSuccess());
      return successMessage;
    } on SocketException catch (e) {
      emit(GenerateEodFailure(errorMessage: e.message));
    } catch (e) {
      emit(GenerateEodFailure(errorMessage: e.toString()));
    }
    return null;
  }
}
