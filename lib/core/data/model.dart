import '../domain/entity.dart';

class ResponseModel extends ResponseEntity {
  const ResponseModel({
    required super.data,
    required super.message,
    super.error,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      data: json['data'],
      message: json['message'],
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'message': message,
      'error': error,
    };
  }
}
