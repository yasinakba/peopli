import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

const  String baseImageURL = 'https://api.peopli.ir/uploads';
const String baseURL = 'https://api.peopli.ir';
var isUploading = false.obs;


bool isConnected = false;
Future<bool> checkInternet()async{
  Connectivity().onConnectivityChanged.listen((status) {
    print(status);
    if(status == ConnectivityResult.wifi|| status == ConnectivityResult.mobile){
      isConnected = true;
    }else {
      isConnected = false;
    }
  },);
    return isConnected;
}

