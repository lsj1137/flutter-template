/*
Date: 2024.09.30
Producer: Se Jun Lim
Email: lsj1137jsl@gmail.com
ReadMe:
This document is about dio's interceptor, which is for http request/response.
There is a content about reissuing JWT access/refresh token.
Dependency documents:
https://pub.dev/packages/dio
*/

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //TODO Start Loading

    // Before Request
    print('Request: [${options.method}] ${options.path}');

    // Continue Request
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //TODO End Loading

    // Got successful response
    print('Response: [${response.statusCode}] ${response.data}');
    // Continue Reponse
    return handler.next(response);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // When error occurs
    // TODO Stop Loading

    print('Error: [${err.response?.statusCode}] ${err.message}');

    // reissue token
    if (err.response?.statusCode == 401) {
      var refreshToken = await storage.read(key: 'refreshToken');
      try {
        var response = await dioInstance.post(url, data: {'refresh': refreshToken},);

        var newAccessToken = response.data['access'];
        var newRefreshToken = response.data['refresh'];

        if (newAccessToken != null) {
          await storage.write(key: 'accessToken', value: newAccessToken);
          if (newRefreshToken != null) {
            await storage.write(key: 'refreshToken', value: newRefreshToken);
          }
          err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          dioInstance.options.headers['Authorization'] = 'Bearer $newAccessToken';
          return handler.resolve(await dioInstance.fetch(err.requestOptions));
        } else {
          // Reissuing token failed
        }
      } catch (e) {
        // Error while reissuing token
        return handler.next(err);
      }
    } else if (err.response?.statusCode == 404) {
      // Not Found Error

    } else if (err.response?.statusCode == 500) {
      // Server Error
    }

    // Continue Error
    return handler.next(err);
  }
}