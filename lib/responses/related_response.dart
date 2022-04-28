import 'package:movies_app/models/movie.dart';

class RelatedResponse {
  List<Movie> related = [];

  RelatedResponse.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((e) => related.add(Movie.fromJson(e)));
  }
}
