import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/genre_controller.dart';

class GenresScreen extends StatelessWidget {

  final genreController = Get.find<GenreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('${genreController.genres.length}'),
      ),
    );
  }

}