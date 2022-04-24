import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/genre_controller.dart';

class GenresScreen extends StatelessWidget {

  final genreController = Get.find<GenreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            itemCount: genreController.genres.length,
            physics: BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.green, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('${genreController.genres[index].name}', style: TextStyle(fontSize: 18, color: Colors.green)),
                    SizedBox(height: 10),
                    Text('${genreController.genres[index].moviesCount}', style: TextStyle(fontSize: 18, color: Colors.lightGreen)),
                  ],
                ),
              );
            }),
      ),
    );
  }

}