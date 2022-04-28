import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/movie_controller.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/screens/movie_detail_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class MoviesScreen extends StatefulWidget {
  late final String title;
  late final String? type;
  late final int? genreId;


  MoviesScreen({required this.title, this.type, this.genreId});

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {

  final movieController = Get.put(MovieController());
  final scrollController = ScrollController();

  @override
  void initState() {
    movieController.getMovies(genreId: widget.genreId, type: widget.type);

    scrollController.addListener(() {
      var sControllerOffset = scrollController.offset;
      var sControllerMax = scrollController.position.maxScrollExtent - 100;
      var isLoadingPagination = movieController.isLoadingPagination.value;
      var hasMorePages = movieController.currentPage.value < movieController.lastPage.value;

      if (sControllerOffset > sControllerMax && isLoadingPagination == false && hasMorePages) {
        movieController.isLoadingPagination.value = true;
        movieController.currentPage.value++;

        movieController.getMovies(page: movieController.currentPage.value, type: widget.type, genreId: widget.genreId);
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
                      return movieController.getMovies(page: 1, type: widget.type, genreId: widget.genreId);
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
    return InkWell(
      onTap: () {
        Get.to(() => MovieDetailScreen(movie: movie), preventDuplicates: true);
      },
      child: Row(
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
      ),
    );
  }

}
