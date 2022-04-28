import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/home_controller.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/screens/movie_detail.dart';
import 'package:movies_app/screens/movies_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatelessWidget {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Obx(() {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children:<Widget>[
                  buildLandscapeMovieList(title: 'NowPlaying', type: 'now_playing', isLoading: homeController.isLoadingNowPlaying.value, movies: homeController.nowPlayingMovies),
                  SizedBox(height: 20),
                  buildPortraitMovieList(title: 'Popular', type: 'popular', isLoading: homeController.isLoadingPopular.value, movies: homeController.popularMovies),
                  SizedBox(height: 20),
                  buildPortraitMovieList(title: 'Upcoming', type: 'upcoming', isLoading: homeController.isLoadingUpcoming.value, movies: homeController.upcomingMovies),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildLandscapeMovieList({required String title, required String type, required bool isLoading, required List<Movie> movies}) {
    return Column(
      children:<Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget>[
            Text('${title}', style: TextStyle(fontSize: 20, color: Colors.green),),
            InkWell(
              onTap: () {
                Get.to(
                  () => MoviesScreen(type: type),
                  preventDuplicates: false,
                );
              },
              child: Text('Show All...', style: TextStyle(color: Colors.lightGreen)),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 255,
          child: isLoading == true
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return buildLandscapeMovieCard(movie: movies[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 10);
                  },
                  itemCount: movies.length,
                ),
        ),
      ],
    );
  }

  Widget buildLandscapeMovieCard({required Movie movie}) {
    return InkWell(
      onTap: () {
        Get.to(() => MovieDetailScreen(movie: movie), preventDuplicates: false);
      },
      child: Container(
        height: double.infinity,
        width: 340,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children:<Widget>[
              Container(
                width: double.infinity,
                height: 200,
                child: Stack(
                  children:<Widget>[
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: '${movie.banner}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('${movie.title}', style: TextStyle(fontSize: 18, color: Colors.green), overflow: TextOverflow.ellipsis, maxLines: 1),
                    ),
                    SizedBox(width: 5),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star, color: Colors.yellow),
                        Text('${movie.vote}', style: TextStyle(fontSize: 18, color: Colors.lightGreen))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildPortraitMovieList({required String title, required String type, required bool isLoading, required List<Movie> movies}) {
    return Column(
      children:<Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget>[
            Text('${title}', style: TextStyle(fontSize: 20, color: Colors.green),),
            InkWell(
              onTap: () {
                Get.to(
                  () => MoviesScreen(type: type),
                  preventDuplicates: false,
                );
              },
              child: Text('Show All...', style: TextStyle(color: Colors.lightGreen)),
            )
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 240,
          child: isLoading == true
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return buildPortraitMovieCard(movie: movies[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 10);
                  },
                  itemCount: movies.length,
                ),
        ),
      ],
    );
  }

  Widget buildPortraitMovieCard({required Movie movie}) {
    return InkWell(
      onTap: () {
        Get.to(() => MovieDetailScreen(movie: movie), preventDuplicates: false);
      },
      child: Container(
        height: double.infinity,
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            Container(
              width: double.infinity,
              height: 210,
              child: Stack(
                children:<Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: '${movie.poster}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ],
              ),
            ),
            SizedBox(height: 7),
            Text('${movie.title}', style: TextStyle(fontSize: 16, color: Colors.green), overflow: TextOverflow.ellipsis, maxLines: 1),
          ],
        ),
      ),
    );
  }

}
