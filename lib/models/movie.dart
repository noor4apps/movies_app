import 'package:movies_app/models/genre.dart';

class Movie {
  late int id;
  late String title;
  late String description;
  late String poster;
  late String banner;
  late String type;
  late String releaseDate;
  late double vote;
  late int voteCount;
  List<Genre> genres = [];

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    poster = json['poster'];
    banner = json['banner'];
    type = json['type'] ?? '';
    releaseDate = json['release_date'];
    vote = json['vote'].toDouble();
    voteCount = json['vote_count'];
    json['genres'].forEach((genre) => genres.add(Genre.fromJson(genre)));
  }

}
