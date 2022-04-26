import 'package:get/get.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/responses/movie_response.dart';
import 'package:movies_app/services/api.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;
  var isLoadingPagination = false.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var movies = <Movie>[].obs;

  Future<void> getMovies({int page = 1, String? type, int? genreId}) async {

    var response = await Api.getMovies(page: page, type: type, genreId: genreId);
    var movieResponse = MovieResponse.fromJson(response.data);

    if (page == 1) {
      movies.clear();
    }

    movies.addAll(movieResponse.movies);
    lastPage.value = movieResponse.lastPage;

    isLoading.value = false;
    isLoadingPagination.value = false;
  }

}