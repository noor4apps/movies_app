import 'package:get/get.dart';
import 'package:movies_app/models/actor.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/responses/movie_response.dart';
import 'package:movies_app/responses/actor_response.dart';
import 'package:movies_app/responses/related_response.dart';
import 'package:movies_app/services/api.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;
  var isLoadingPagination = false.obs;
  var isLoadingActors = false.obs;
  var isLoadingRelated = false.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  var movies = <Movie>[].obs;
  var actors = <Actor>[].obs;
  var related = <Movie>[].obs;

  Future<void> getMovies({int page = 1, String? type, int? genreId}) async {

    var response = await Api.getMovies(page: page, type: type, genreId: genreId);
    var movieResponse = MovieResponse.fromJson(response.data);

    if (page == 1) {
      movies.clear();
      // for RefreshIndicator
      isLoading.value = true;
      currentPage.value = 1;
    }

    movies.addAll(movieResponse.movies);
    lastPage.value = movieResponse.lastPage;

    isLoading.value = false;
    isLoadingPagination.value = false;
  }

  Future<void> getActors({required int movieId}) async {

    var response = await Api.getActors(movieId: movieId);
    var actorResponse = ActorResponse.fromJson(response.data);

    actors.clear();

    actors.addAll(actorResponse.actors);

    isLoadingActors.value = false;
  }

  Future<void> getRelated({required int movieId}) async {

    var response = await Api.getRelated(movieId: movieId);
    var relatedResponse = RelatedResponse.fromJson(response.data);

    related.clear();

    related.addAll(relatedResponse.related);

    isLoadingRelated.value = false;
  }

}