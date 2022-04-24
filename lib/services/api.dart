import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as GET;
import 'package:get_storage/get_storage.dart';

class Api {

  static final dio = Dio(
    BaseOptions(
        baseUrl: 'http://10.0.2.2/movies/public',
        receiveDataWhenStatusError: true
    ),
  );

  static void initializeInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(

        onRequest: (request, handler) async {
          var token = await GetStorage().read('login_token');
          var headers = {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${token}'
          };

          request.headers.addAll(headers);

          print('${request.method} ${request.path}');
          print('${request.headers}');

          return handler.next(request);
        },

        onResponse: (response, handler) {
          print('${response.data}');

          if(response.data['error'] == 1) throw response.data['message'];

          return handler.next(response);
        },

        onError: (error, handler) {
          if (GET.Get.isDialogOpen == true) {
            GET.Get.back();
          }
          GET.Get.snackbar(
              'error'.tr,
              '${error.message}',
              snackPosition: GET.SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white
          );
          return handler.next(error);
        }

    ));
  }

  static Future<Response> getGenres() async {
    return dio.get('/api/genres');
  }

  static Future<Response> getMovies(String type) async {
    return dio.get('/api/movies', queryParameters: {
      'type': type
    });
  }

}
