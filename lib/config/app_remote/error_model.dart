
import 'package:flutter/foundation.dart';

class ErrorModel   {
  final Map<String, dynamic>? errors;
   String? message;
   ErrorModel({
    this.message,
    this.errors =const {},
  });


  factory ErrorModel.fromMap(Map<String, dynamic> json) {
    try {
      debugPrint(json['detail']);

    return ErrorModel(
        message: json['detail'],
        // errors: json["errors"],

      );

    } catch (e) {

      return ErrorModel(
        message: e.toString(),
      );
    }
  }

  @override
  String toString() {
    return "$message";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ErrorModel &&
        other.message == message &&
        other.errors == other.errors;
  }

  @override
  int get hashCode => message.hashCode;
}
