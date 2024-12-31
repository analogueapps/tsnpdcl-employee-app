import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tsnpdcl_employee/network/api_urls.dart';

import 'logging_interceptor.dart';

class ApiClient {
  final Dio dio;

  static const int timeOutDuration = 200;

  ApiClient({required String baseUrl}) : dio = Dio() {
    // Set common configuration options for the Dio instance
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(seconds: timeOutDuration); // 20 seconds
    dio.options.receiveTimeout = const Duration(seconds: timeOutDuration); // 20 seconds

    // add 'Accept': 'application/json' headers
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Content-Type'] = 'application/json';

    // // You can also add common headers or interceptors here
    // dio.options.headers['Authorization'] = 'Bearer $authToken';

    // Add interceptors (if needed)
    dio.interceptors.add(LoggingInterceptor(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 100,
      enabled: kDebugMode,
    ));

    //***** If you want to send token in header means un commend this one*****//
    // // Optionally add an interceptor to dynamically update the Authorization header
    // dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) async {
    //     String authToken = SharedPreferenceHelper.getAuthToken();
    //     //options.headers['Content-Type'] = 'application/json';
    //     options.headers['Authorization'] = 'Bearer $authToken';
    //     AlertUtils.printValue("Authorization", 'Bearer $authToken');
    //     return handler.next(options); // Continue with the request
    //   },
    // ));
  }

  String getBaseURL () {
    return dio.options.baseUrl;
  }
}