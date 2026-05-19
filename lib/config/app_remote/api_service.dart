import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';


import '../app_remote/dio_error.dart';

// class ApiService with DioMixin implements Dio {
//   ApiService() {
//
//     options = BaseOptions(
//       baseUrl: baseUrl(),
//       contentType: 'application/json',
//       followRedirects: false,
//     );
//
//     interceptors.add(
//       InterceptorsWrapper(
//         onResponse: (response, handler) {
//          log("\n\n************************************************\n\nRESPONSE DESCRIPTION   \nrequest=${response.realUri}\nheader=${response.headers}\nstatuscode=${response.statusCode}\n body=${response.requestOptions.data} \ndata=${response.data}\n************************************************\n\n");
//           handler.next(response);
//         },
//         onRequest: (options, handler) async {
//           String? salonId =await locator<LocalStorage>().get(AppKeyLocalStorage.keySalonId, Types.string);
//           options.headers.addAll(await _getHeader());
//
//           log("\n\n ******************************* REQUEST\n\n url=${options.path}\n body=${options.data} \n queryParameters=${options.queryParameters} \n header=${options.headers}\n\n********************\n");
//           handler.next(options);
//         },
//
//
//
//
//
//
//
//
//         onError: (e, handler) async {
//           locator<Logger>().e(e.toString());
//           locator<Logger>().e(e.response);
//           locator<Logger>().e(e.requestOptions.path);
//           locator<Logger>().e(e.requestOptions.queryParameters);
//
//           if(e.response==null){
//             bool isConnected=await   locator<NetworkInfoPkg>().isConnected;
//             if (isConnected ==false) {
//
//
//               await disconnectWiFiBottomSheet();
//
//
//               try {
//                 final response = await request(
//                   e.requestOptions.path,
//                   options: Options(
//                     method: e.requestOptions.method,
//                     headers: e.requestOptions.headers,
//                   ),
//                   data: e.requestOptions.data,
//                   queryParameters: e.requestOptions.queryParameters,
//                 );
//
//                 return handler.resolve(response); // Return the successful response
//               } catch (e) {
//                 return handler.next(e as CustomizeDioError); // If retry fails, pass the error forward
//               }
//             }
//
//           }
//
//
//           if (e.response?.statusCode == 401) {
//             try {
//               final tokenHandler = TokenRefreshHandler();
//               final newToken = await tokenHandler.refreshToken();
//
//               e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
//               final opts = Options(
//                 method: e.requestOptions.method,
//                 headers: e.requestOptions.headers,
//               );
//
//               final retryResponse = await request(
//                 e.requestOptions.path,
//                 options: opts,
//                 data: e.requestOptions.data,
//                 queryParameters: e.requestOptions.queryParameters,
//               );
//
//               return handler.resolve(retryResponse);
//             } catch (e) {
//               return handler.reject(e as CustomizeDioError);
//             }
//           }
//
//
//
//
//           handler.next(CustomizeDioError.fromResponse(e));
//         },
//       ),
//     );
//     httpClientAdapter = HttpClientAdapter();
//   }
//
//   Future<String> refreshToken() async {
//     final refreshToken = await _getRefreshToken();
//     options = BaseOptions(
//       baseUrl: baseUrl(),
//       contentType: 'application/json',
//       connectTimeout:Duration( milliseconds: 900000) ,
//       sendTimeout:Duration( milliseconds: 800000) ,
//       receiveTimeout: Duration( milliseconds: 800000) ,
//       followRedirects: false,
//     );
//     try {
//       final response = await Dio(options)
//           .post('/account/api/token/refresh/', data: {'refresh': refreshToken});
//
//       if (response.statusCode == 200) {
//
//        var a= await locator<LocalStorage>().set(AppKeyLocalStorage.keyToken, response.data['access'],Types.string,);
//        var b= await locator<LocalStorage>().get(AppKeyLocalStorage.keyToken,Types.string,);
//
//
//         return response.data['access'];
//
//       } else {
//
//         // NavKey.navKey.currentState?.pushNamedAndRemoveUntil(
//         //     WinballRoutes.signInScreen, (route) => false);
//
//
//         return '';
//       }
//     } catch (e) {
//       // _logoutUser();
//       // NavKey.navKey.currentState?.pushNamedAndRemoveUntil(
//       //     WinballRoutes.signInScreen, (route) => false);
//
//
//
//       return '';
//     }
//   }
//
//   // Future<String> _getRefreshToken() async {
//   //
//   //   return await locator<LocalStorage>()
//   //       .get(AppKeyLocalStorage.keyRefreshToken,Types.string);
//   // }
//
//   Future<Map<String, String>> _getHeader() async {
//     String? token =await locator<LocalStorage>().get(AppKeyLocalStorage.keyToken, Types.string);
//     String? salonId =await locator<LocalStorage>().get(AppKeyLocalStorage.keySalonId, Types.string);
//     if (token != null && token.isNotEmpty) {
//       log("_getHeader token $token");
//       log("_salonId =====> $salonId");
//
//       final headers = {
//
//         "Accept": "application/json",
//         "Authorization": 'Bearer $token',
//         "Content-Type": "application/json",
//       };
//
//       return headers ;
//     }
//     return {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     };
//   }
//
//   Future<Response> getAsync(String endPoint, {CancelToken? cancelToken,Map<String, dynamic>?  queryParameters}) async {
//
//     String base = baseUrl();
//
//     var response = await get("$base$endPoint", cancelToken: cancelToken,
//
//       queryParameters:queryParameters ,);
//     return response;
//   }
//
//   Future<Response> putAsync(String endPoint,
//       {Map<String, dynamic>? data}) async {
//     String base = baseUrl();
//     var response = await put(
//       "$base/$endPoint",
//       data: jsonEncode(data),
//     );
//
//     return response;
//   }
//
//   Future<Response> patchAsync(String endPoint,
//       {Map<String, dynamic>? data}) async {
//     String base = baseUrl();
//     var response = await patch(
//       "$base$endPoint",
//       data: jsonEncode(data),
//     );
//
//     return response;
//   }
//
//   Future<Response> postAsync(String endPoint,
//       { Map<String, dynamic>? data, Map<String, dynamic>? queryParameters}) async {
//     String base = baseUrl();
//     debugPrint("$base$endPoint");
//     var response = await post(
//       "$base$endPoint",
//       data: data,
//       queryParameters: queryParameters
//     );
//
//     return response;
//   }
//
//
//   String baseUrl() {
//     String baseUrl = dotenv.env['BASE_URL'] as String;
//     return baseUrl;
//   }
//
//   Future<Response> postFileAsync(String endPoint,
//       {required FormData data}) async {
//     String base = baseUrl();
//     Map<String, String> header = await _getHeader();
//     Options options = Options(
//       headers: header,
//       contentType: 'multipart/form-data',
//       followRedirects: false,
//     );
//     var response =
//         await Dio().post("$base$endPoint", data: data, options: options);
//
//     return response;
//   }
//
// //   @override
// //   Future<Response> download(String urlPath, savePath, {ProgressCallback? onReceiveProgress, Map<String, dynamic>? queryParameters, CancelToken? cancelToken, bool deleteOnError = true, String lengthHeader = Headers.contentLengthHeader, Object? data, Options? options}) {
// //     // TODO: implement download
// //
// //     throw UnimplementedError();
// //   }
// }
//
//
//
// class TokenRefreshHandler {
//   static bool _isRefreshing = false;
//   static final List<Completer<String>> _pendingRequests = [];
//
//   // Future<String> refreshToken() async {
//   //   if (_isRefreshing) {
//   //     final completer = Completer<String>();
//   //     _pendingRequests.add(completer);
//   //     return await completer.future;
//   //   }
//   //
//   //   _isRefreshing = true;
//   //
//   //   try {
//   //     final refToken = await  locator<LocalStorage>()
//   //         .get(AppKeyLocalStorage.keyRefreshToken,Types.string);
//   //
//   //
//   //
//   //     final options = BaseOptions(
//   //       baseUrl: ApiService().baseUrl(),
//   //       contentType: 'application/json',
//   //       connectTimeout: Duration(milliseconds: 30000),
//   //       sendTimeout: Duration(milliseconds: 30000),
//   //       receiveTimeout: Duration(milliseconds: 30000),
//   //       followRedirects: false,
//   //     );
//   //
//   //     final response = await Dio(options)
//   //         .post('/account/api/token/refresh/', data: {'refresh_token': refToken});
//   //
//   //
//   //     if (response.statusCode == 200) {
//   //       var setToken= await locator<LocalStorage>().set(AppKeyLocalStorage.keyToken, response.data['access'],Types.string,);
//   //       var getNewToken= await locator<LocalStorage>().get(AppKeyLocalStorage.keyToken,Types.string,);
//   //
//   //
//   //
//   //       _completePendingRequests(getNewToken);
//   //
//   //       return getNewToken;
//   //     } else {
//   //       _handleRefreshFailure();
//   //       throw Exception('Refresh token failed with status ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     _handleRefreshFailure();
//   //     throw e;
//   //   } finally {
//   //     _isRefreshing = false;
//   //   }
//   // }
//
//   // void _completePendingRequests(String newToken) {
//   //   for (final completer in _pendingRequests) {
//   //     if (!completer.isCompleted) {
//   //       completer.complete(newToken);
//   //     }
//   //   }
//   //   _pendingRequests.clear();
//   // }
//
//   // void _handleRefreshFailure() {
//   //   // لاگ‌اوت کاربر در صورت شکست رفرش توکن
//   //   _logoutUser();
//   //
//   //   // تمام درخواست‌های منتظر را با خطا پاسخ بده
//   //   for (final completer in _pendingRequests) {
//   //     if (!completer.isCompleted) {
//   //       completer.completeError('Failed to refresh token');
//   //     }
//   //   }
//   //   _pendingRequests.clear();
//   //
//   //   // Navigate to login screen
//   //   // NavKey.navKey.currentState?.pushNamedAndRemoveUntil(
//   //   //     WinballRoutes.signInScreen, (route) => false);
//   // }
//
//   Future<void> _logoutUser() async {
//     // پیاده‌سازی لاگ‌اوت کاربر
//   }
// }
