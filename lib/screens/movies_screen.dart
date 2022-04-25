import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/movie_controller.dart';
import 'package:movies_app/models/movie.dart';
import 'package:transparent_image/transparent_image.dart';

class MoviesScreen extends StatefulWidget {
  late final String? type;
  late final int? genreId;


  MoviesScreen({this.type, this.genreId});

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {

  final moviesController = Get.put(MovieController());

  @override
  void initState() {
    moviesController.getMovies(genreId: widget.genreId, type: widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies', style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.w600)),
      ),
        body: Obx(() {
          return moviesController.isLoading.value == true
              ? Container(
                  child: Center(child: CircularProgressIndicator())
                )
              : Container(
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildMovieItem(moviesController.movies.value[index]);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemCount: moviesController.movies.length,
                    ),
                  ),
                );
        }));
  }

  Widget buildMovieItem(Movie movie) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 130,
          height: 200,
          child: Stack(
            children: [
              Center(child: CircularProgressIndicator()),
              FadeInImage.memoryNetwork(
                image: '${movie.poster}',
                placeholder: kTransparentImage,
              ),
            ],
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('${movie.title}', style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis, maxLines: 2),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star, color: Colors.yellow),
                      Text('${movie.vote}', style: TextStyle(fontSize: 18, color: Colors.lightGreen))
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                '${movie.description}',
                style: TextStyle(fontSize: 15, color: Colors.lightGreen[200]),
                overflow: TextOverflow.ellipsis,
                maxLines: 8,
              ),
            ],
          ),
        )
      ],
    );
  }

}
