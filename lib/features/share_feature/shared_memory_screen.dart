import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_test_test/config/app_string/constant.dart';
import 'package:test_test_test/features/first_screen/widget/post_first_screen.dart';
import 'package:test_test_test/features/share_feature/share_memory_model.dart';


class SharedMemoryScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // getMemoryShared(id: );
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          // child: PostFirstScreen(, 1,[]),
          child: Container(),
        ),
      ),
    );
  }
}
final dio = Dio();
// ShareMemoryModel shareMemoryModel = ShareMemoryModel();
// Future getMemoryShared({id})async{
//   final response = await dio.get('$baseURL/Api/Api/Memories/$id',);
//   shareMemoryModeld = response.data['data'];
// }
