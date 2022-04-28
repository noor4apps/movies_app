import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieDetailScreen extends StatefulWidget {

  final Movie movie;

  MovieDetailScreen({required this.movie});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  
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
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDetails(movie: widget.movie),
                  SizedBox(height: 10),
                  buildActors()
                ],
              ),
            ),
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
        Container(width: 160, child: Text('Actors ', style: TextStyle(fontSize: 18))),
        SizedBox(height: 10),
        Container(
          height: 270,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: false,
            itemBuilder: (context, index) {
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
                            image: 'https://via.placeholder.com/150',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text('actor name', overflow: TextOverflow.ellipsis, maxLines: 1)
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {return SizedBox(width: 10);},
            itemCount: 4,
          ),
        ),
      ],
    );
  }

}
