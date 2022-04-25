import 'package:get/get.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/responses/movie_response.dart';
import 'package:movies_app/services/api.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;
  var movies = <Movie>[].obs;

  Future<void> getMovies({int page = 1, String? type, int? genreId}) async {
    isLoading.value = true;

    var response = await Api.getMovies(page: page, type: type, genreId: genreId);
    var movieResponse = MovieResponse.fromJson(response.data);

    movies.clear();
    movies.addAll(movieResponse.movies);
    isLoading.value = false;
  }

}