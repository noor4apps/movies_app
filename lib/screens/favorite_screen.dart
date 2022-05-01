import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/movie_controller.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/movie_item_widget.dart';

class FavoriteScreen extends StatefulWidget {
  late final String title;

  FavoriteScreen({required this.title});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  final movieController = Get.put(MovieController());
  final scrollController = ScrollController();

  @override
  void initState() {
    movieController.getFavorite();

    scrollController.addListener(() {
      var sControllerOffset = scrollController.offset;
      var sControllerMax = scrollController.position.maxScrollExtent - 100;
      var isLoadingPagination = movieController.isLoadingPagination.value;
      var hasMorePages = movieController.currentPage.value < movieController.lastPage.value;

      if (sControllerOffset > sControllerMax && isLoadingPagination == false && hasMorePages) {
        movieController.isLoadingPagination.value = true;
        movieController.currentPage.value++;

        movieController.getFavorite(page: movieController.currentPage.value);
      }

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.title}', style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.w600)),
        ),
        body: Obx(() {
          return movieController.isLoading.value == true
              ? Center(child: CircularProgressIndicator())
              : Container(
            padding: const EdgeInsets.all(12),
            child: RefreshIndicator(
              onRefresh: () {
                return movieController.getFavorite(page: 1);
              },
              child: SingleChildScrollView(
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return buildMovieItem(movieController.movies.value[index]);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemCount: movieController.movies.length,
                    ),
                    Visibility(
                      visible: movieController.isLoadingPagination.value,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        width: 40,
                        height: 40,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Widget buildMovieItem(Movie movie) {
    return MovieItemWidget(movie: movie);
  }

}

