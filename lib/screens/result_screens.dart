import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/constants/m_colors.dart';
import 'package:movies_app/constants/sizes.dart';
import 'package:movies_app/controllers/movie_controller.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/movie_item_widget.dart';

class ResultScreen extends StatefulWidget {
  late final String? searchWord;

  ResultScreen({this.searchWord});

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final moviesController = Get.put(MovieController());

  @override
  void initState() {
    moviesController.search(keyWord: widget.searchWord);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results', style: TextStyle(fontSize: Sizes.screen, color: MColors.secondary, fontWeight: FontWeight.w600)),
      ),
      body: Obx(() {
        return moviesController.isLoading.value == true
            ? Container(child: Center(child: CircularProgressIndicator()))
            : moviesController.movies.length >= 1
                ? Container(
                    padding: const EdgeInsets.all(12),
                    child: SingleChildScrollView(
                      child: ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildMovieItem(
                              moviesController.movies.value[index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                        itemCount: moviesController.movies.length,
                      ),
                    ),
                  )
                : Center(child: Text('Not Found Result!'));
      }),
    );
  }

  Widget buildMovieItem(Movie movie) {
    return MovieItemWidget(movie: movie);
  }

}
