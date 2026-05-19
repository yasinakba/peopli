import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'error_model.dart';

class CustomizeDioError extends DioException {
  final RequestOptions options;

  CustomizeDioError({error, required this.options, String? message})
      : super(requestOptions: options, error: error, message: message);

  factory CustomizeDioError.fromResponse(e) {
    try {
      if (e.response == null) {
        final errorModel = ErrorModel(message: 'خطای ارتباط با سرور');
        return CustomizeDioError(
          message: 'خطای ارتباط با سرور',
          error: errorModel,
          options: e.requestOptions,
        );
      }

      if (e.response!.statusCode! >= 500) {
        return CustomizeDioError(
          message: 'سرور قادر به پاسخگویی نیست',
          error: ErrorModel(message: 'سرور قادر به پاسخگویی نیست'),
          options: e.requestOptions,
        );
      }


      return CustomizeDioError(
        message: getMessage(e.response!.data),
        error: ErrorModel.fromMap(e.response!.data),
        options: e.requestOptions,
      );
    } catch (e) {
      debugPrint(e.toString());
      return CustomizeDioError(
          message: "خطا",
          error: ErrorModel(message: "خطا"),
          options: RequestOptions());
    }

  }
}

getMessage(Map<String, dynamic> map) {
  try {
    // String message = map['meta']['msg'];
    String message = map['detail'];

    return message;
  } catch (e) {
    String message = "unkown toast";
    return message;
  }
}
