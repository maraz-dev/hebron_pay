import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_cubit_state.dart';

class SignUpCubitCubit extends Cubit<SignUpCubitState> {
  SignUpCubitCubit() : super(SignUpCubitInitial());
}
