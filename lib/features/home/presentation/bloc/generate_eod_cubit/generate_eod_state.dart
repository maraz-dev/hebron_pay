part of 'generate_eod_cubit.dart';

abstract class GenerateEodState extends Equatable {
  const GenerateEodState();

  @override
  List<Object> get props => [];
}

class GenerateEodInitial extends GenerateEodState {}

class GenerateEodLoading extends GenerateEodState {}

class GenerateEodSuccess extends GenerateEodState {}

class GenerateEodFailure extends GenerateEodState {
  final String errorMessage;

  const GenerateEodFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
