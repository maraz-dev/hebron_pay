import 'package:equatable/equatable.dart';

class GetTrxEntity extends Equatable {
  final int id;
  final String description;
  final int amount;
  final String reference;
  final String type;
  final String date;
  final String time;
  final String username;

  const GetTrxEntity({
    required this.id,
    required this.description,
    required this.amount,
    required this.reference,
    required this.type,
    required this.date,
    required this.time,
    required this.username,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
