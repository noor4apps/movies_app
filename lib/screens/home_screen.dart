import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/constants/m_colors.dart';
import 'package:movies_app/constants/sizes.dart';
import 'package:movies_app/controllers/home_controller.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/screens/movie_detail_screen.dart';
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
                  buildLandscapeMovieList(title: 'Now Playing', type: 'now_playing', isLoading: homeController.isLoadingNowPlaying.value, movies: homeController.nowPlayingMovies),
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
            Text('${title}', style: TextStyle(fontSize: Sizes.section, color: MColors.primary),),
            InkWell(
              onTap: () {
                Get.to(
                  () => MoviesScreen(title: title, type: type),
                  preventDuplicates: false,
                );
              },
              child: Text('Show All...', style: TextStyle(color: MColors.secondary, fontSize: Sizes.section)),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: Get.height / 3 + 60,
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
        width: Get.width - 60,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            children:<Widget>[
              Container(
                width: double.infinity,
                height: Get.height / 3,
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
                      child: Text('${movie.title}', style: TextStyle(fontSize: Sizes.titleCart, color: MColors.tertiary), overflow: TextOverflow.ellipsis, maxLines: 1),
                    ),
                    SizedBox(width: 5),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star, color: MColors.yellow, size: Sizes.starIconCart),
                        Text('${movie.vote}', style: TextStyle(fontSize: Sizes.starNumberCart, color: MColors.secondary))
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
            Text('${title}', style: TextStyle(fontSize: Sizes.section, color: MColors.primary),),
            InkWell(
              onTap: () {
                Get.to(
                  () => MoviesScreen(title: title, type: type),
                  preventDuplicates: false,
                );
              },
              child: Text('Show All...', style: TextStyle(color: MColors.secondary, fontSize: Sizes.section)),
            )
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: Get.height / 3,
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
        width: Get.width / 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            Container(
              width: double.infinity,
              height: Get.height / 3.5,
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
            Text('${movie.title}', style: TextStyle(fontSize: Sizes.titleCart, color: MColors.tertiary), overflow: TextOverflow.ellipsis, maxLines: 1),
          ],
        ),
      ),
    );
  }

}
