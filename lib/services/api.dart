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

  static Future<Response> getMovies({int page = 1, String? type, int? genreId, int? actorId}) async {
    return dio.get('/api/movies', queryParameters: {
      'page': page,
      'type': type,
      'genre_id': genreId,
      'actor_id': actorId,
    });
  }

  static Future<Response> getActors({required int movieId}) async {
    return dio.get('/api/movies/${movieId}/actors');
  }

  static Future<Response> getRelated({required int movieId}) async {
    return dio.get('/api/movies/${movieId}/related');
  }

  static Future<Response> login({required Map<String, dynamic> loginData}) async {
    FormData formData = FormData.fromMap(loginData);

    return dio.post('/api/login', data: formData);
  }

  static Future<Response> logout() async {
    return dio.get('/api/logout');
  }

  static Future<Response> getUser() async {
    return dio.get('/api/user');
  }

  static Future<Response> register({required Map<String, dynamic> registerData}) async {
    FormData formData = FormData.fromMap(registerData);

    return dio.post('/api/register', data: formData);
  }

  static Future<Response> isFavored({required int movieId}) async {
    return dio.get('/api/movies/${movieId}/is-favored');
  }

  static Future<Response> toggleFavorite({required int movieId}) {
    return dio.get('/api/movies/toggle-favorite', queryParameters: {'movie_id': movieId});
  }

  static Future<Response> getFavorite({int page = 1}) {
    return dio.get('/api/movies/favorite', queryParameters: {'page': page});
  }

  static Future<Response> search({String? keyWord}) async {
    return dio.get('/api/movies', queryParameters: {
      'search': keyWord,
    });
  }

}
