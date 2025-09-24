import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
final dio = Dio();

Future<void> signIn() async {
  try {
    final response = await dio.post(
      "https://api.peopli.ir/Api/login?username=yasin&password=yasinak",
      data: {
        "title": "foo",
        "body": "bar",
        "userId": 1,
      },
    );
    print("POST success: ${response.data}");
  } on DioException catch (e) {
    print("POST error: ${e.response?.statusCode} - ${e.message}");
  }
}
}