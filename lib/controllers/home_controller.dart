import 'package:get/get.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/responses/movie_response.dart';
import 'package:movies_app/services/api.dart';

class HomeController extends GetxController {
  var isLoadingNowPlaying = true.obs;
  var isLoadingUpcoming = true.obs;
  var isLoadingTrending = true.obs;

  var nowPlayingMovies = <Movie>[];
  var upcomingMovies = <Movie>[];
  var trendingMovies = <Movie>[];

  @override
  onInit() async {
    await getNowPlayingMovies();
    super.onInit();
  }

  Future<void> getNowPlayingMovies() async {
    isLoadingNowPlaying.value = true;

    nowPlayingMovies.clear();

    var response = await Api.getMovies('now_playing');
    var movieResponse = MovieResponse.fromJson(response.data);

    nowPlayingMovies.addAll(movieResponse.movies);

    isLoadingNowPlaying.value = false;
  }

}
