import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/constants/m_colors.dart';
import 'package:movies_app/constants/sizes.dart';
import 'package:movies_app/controllers/auth_controller.dart';
import 'package:movies_app/controllers/movie_controller.dart';
import 'package:movies_app/models/actor.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/screens/actor_screen.dart';
import 'package:movies_app/screens/login_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDetailScreen extends StatefulWidget {

  final Movie movie;

  MovieDetailScreen({required this.movie});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {

  final movieController = Get.find<MovieController>();
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    movieController.getActors(movieId: widget.movie.id);
    movieController.getRelated(movieId: widget.movie.id);
    movieController.isFavored(movieId: widget.movie.id);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              expandedHeight: 300,
              backgroundColor: MColors.primary,
              actions: [
                authController.isLoggedIn.value == false
                    ? IconButton(
                        onPressed: () {
                          Get.to(() => LoginScreen(), preventDuplicates: false);
                        },
                        icon: Icon(Icons.favorite_border),
                      )
                    : movieController.isLoadingIsFavored.value == true
                        ? Center(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: MColors.white,
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: () {movieController.toggleFavorite(movieId: widget.movie.id);},
                            icon: Icon(movieController.isFavoredMovie.value == true ? Icons.favorite : Icons.favorite_border),
                          )
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: buildTopBanner(movie: widget.movie),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDetails(movie: widget.movie),
                    SizedBox(height: 10),
                    buildActors(),
                    SizedBox(height: 10),
                    buildRelated()
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildTopBanner({required Movie movie}) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Image.network('${movie.banner}', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(.2), Colors.black.withOpacity(.6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Chip(
                backgroundColor: MColors.primary,
                padding: const EdgeInsets.all(0),
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.star, color: MColors.black, size: Sizes.starIconDetail),
                    Text('${movie.vote}', style: TextStyle(fontSize: Sizes.starNumberDetail, color: MColors.black))
                  ],
                ),
              ),
              Text('${movie.title}', style: TextStyle(fontSize: Sizes.titleDetail, fontWeight: FontWeight.w600), maxLines: 2, overflow: TextOverflow.ellipsis),
              Wrap(
                spacing: 5,
                runSpacing: -10,
                children: [
                  ...movie.genres.map((genre) {
                    return Chip(label: Text('${genre.name}', style: TextStyle(fontSize: Sizes.genreDetail)));
                  })
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildDetails({required Movie movie}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: TextStyle(fontSize: Sizes.section)),
        SizedBox(height: 10),
        Text('${movie.description}', style: TextStyle(fontSize: Sizes.descriptionDetail, height: 1.3, color: MColors.tertiary)),
        SizedBox(height: 10),
        Row(
          children: [
            Container(width: 160, child: Text('Release Date ', style: TextStyle(fontSize: Sizes.section))),
            Text('${movie.releaseDate}', style: TextStyle(fontSize: Sizes.releaseDateDetail, height: 1.3, color: MColors.tertiary))
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(width:160, child: Text('Vote Count ', style: TextStyle(fontSize: Sizes.section))),
            Text('${movie.voteCount}', style: TextStyle(fontSize: Sizes.voteCountDetail, height: 1.3, color: MColors.tertiary))
          ],
        ),
      ],
    );
  }

  Widget buildActors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Actors ', style: TextStyle(fontSize: Sizes.section)),
        SizedBox(height: 10),
        Container(
          height: Get.height / 3 + 40,
          child: movieController.isLoadingActors.value
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            shrinkWrap: false,
            itemBuilder: (context, index) {
              return buildActor(actor: movieController.actors[index]);
            },
            separatorBuilder: (context, index) {return SizedBox(width: 10);},
            itemCount: movieController.actors.length,
          ),
        ),
      ],
    );
  }

  Widget buildActor({required Actor actor}) {
    return InkWell(
      onTap: () {
        Get.to(()=> ActorScreen(actor: actor), preventDuplicates: false);
      },
      child: Container(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Get.height / 3,
              child: Stack(
                // alignment: Alignment.bottomLeft,
                children: [
                  Center(child: CircularProgressIndicator()),
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: '${actor.image}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text('${actor.name}', overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: Sizes.actorCart),)
          ],
        ),
      ),
    );
  }

  Widget buildRelated() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Related Movies', style: TextStyle(fontSize: Sizes.section)),
        SizedBox(height: 10),
        Container(
          height: Get.height / 2 + 10,
          child: movieController.isLoadingRelated.value
              ? Center(child: CircularProgressIndicator())
              :ListView.separated(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: false,
                itemBuilder: (context, index) {
                  int halfIndex = movieController.related.length ~/ 2;
                  return Column(
                    children: [
                      buildRelatedItem(movie: movieController.related[index]),
                      SizedBox(height: 10),
                      buildRelatedItem(movie: movieController.related[halfIndex + index])
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 10);
                },
                itemCount: movieController.related.length ~/ 2,
          ),
        ),
      ],
    );
  }

  Widget buildRelatedItem({required Movie movie}) {
    return InkWell(
      onTap: () {
        Get.to(() => MovieDetailScreen(movie: movie), preventDuplicates: false);
      },
      child: Container(
        width: Get.width - 40,
        height: Get.height / 4,
        child: Row(
          children: [
            Container(
              width: Get.width / 3.5,
              height: double.infinity,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Center(child: CircularProgressIndicator()),
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: '${movie.poster}',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
            SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('${movie.title}', style: TextStyle(fontSize: Sizes.titleCart,color: MColors.secondary), maxLines: 1, overflow: TextOverflow.ellipsis,),),
                      Icon(Icons.star, color: MColors.secondary, size: Sizes.starIconCart),
                      Text('${movie.vote}', style: TextStyle(fontSize: Sizes.starNumberCart, color: MColors.secondary)),
                    ],
                  ),
                  SizedBox(width: 5),
                  Text('${movie.description}', style: TextStyle(fontSize: Sizes.descriptionCart,color: MColors.tertiary), maxLines: 3, overflow: TextOverflow.ellipsis),
                  Wrap(
                    spacing: 3,
                    runSpacing: -12,
                    children: [
                      ...movie.genres.take(2).map((genre) {
                        return Chip(label: Text('${genre.name}', style: TextStyle(fontSize: Sizes.genreCart)));
                      })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
