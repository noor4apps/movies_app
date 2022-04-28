import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/movie_controller.dart';
import 'package:movies_app/models/actor.dart';
import 'package:movies_app/models/movie.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDetailScreen extends StatefulWidget {

  final Movie movie;

  MovieDetailScreen({required this.movie});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {

  final movieController = Get.find<MovieController>();

  @override
  void initState() {
    movieController.getActors(movieId: widget.movie.id);
    movieController.getRelated(movieId: widget.movie.id);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 300,
            backgroundColor: Colors.green,
            flexibleSpace: FlexibleSpaceBar(
              background: buildTopBanner(movie: widget.movie),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx((){
              return Container(
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
              );
            })
          ),
        ],
      ),
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
                backgroundColor: Colors.green,
                padding: const EdgeInsets.all(0),
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.black),
                    Text('${movie.vote}', style: TextStyle(fontSize: 18, color: Colors.black))
                  ],
                ),
              ),
              Text('${movie.title}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600), maxLines: 2, overflow: TextOverflow.ellipsis),
              Wrap(
                spacing: 5,
                runSpacing: -10,
                children: [
                  ...movie.genres.map((genre) {
                    return Chip(label: Text('${genre.name}', style: TextStyle(fontSize: 13)));
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
        Text('Description', style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Text('${movie.description}', style: TextStyle(fontSize: 16, height: 1.3, color: Colors.lightGreen[200])),
        SizedBox(height: 10),
        Row(
          children: [
            Container(width: 160, child: Text('Release Date ', style: TextStyle(fontSize: 18))),
            Text('${movie.releaseDate}', style: TextStyle(fontSize: 16, height: 1.3, color: Colors.lightGreen[200]))
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(width:160, child: Text('Vote Count ', style: TextStyle(fontSize: 18))),
            Text('${movie.voteCount}', style: TextStyle(fontSize: 16, height: 1.3, color: Colors.lightGreen[200]))
          ],
        ),
      ],
    );
  }

  Widget buildActors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Actors ', style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Container(
          height: 270,
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
    return Container(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 160,
            height: 230,
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
          Text('${actor.name}', overflow: TextOverflow.ellipsis, maxLines: 1)
        ],
      ),
    );
  }

  Widget buildRelated() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Related Movies', style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),
        Container(
          height: 450,
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
        width: 350,
        height: 220,
        child: Row(
          children: [
            Container(
              width: 150,
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
                      Expanded(child: Text('${movie.title}', style: TextStyle(fontSize: 16,color: Colors.lightGreen), maxLines: 1, overflow: TextOverflow.ellipsis,),),
                      Icon(Icons.star, color: Colors.lightGreen, size: 16),
                      Text('${movie.vote}', style: TextStyle(fontSize: 16, color: Colors.lightGreen)),
                    ],
                  ),
                  SizedBox(width: 5),
                  Text('${movie.description}', style: TextStyle(fontSize: 14,color: Colors.lightGreen[200]), maxLines: 3, overflow: TextOverflow.ellipsis),
                  Wrap(
                    spacing: 3,
                    runSpacing: -12,
                    children: [
                      ...movie.genres.take(4).map((genre) {
                        return Chip(label: Text('${genre.name}', style: TextStyle(fontSize: 12)));
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
