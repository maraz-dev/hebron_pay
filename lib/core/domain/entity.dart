import 'package:equatable/equatable.dart';

class ResponseEntity extends Equatable {
  final dynamic data;
  final dynamic message;
  final dynamic error;

  const ResponseEntity({
    required this.data,
    required this.message,
    this.error,
  });

  @override
  List<Object?> get props => [
        data,
        message,
        error,
      ];
}
