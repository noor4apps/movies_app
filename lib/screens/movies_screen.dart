import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/movie_controller.dart';

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
      body: moviesController.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: null,
            ),
    );
  }

}
