import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/screens/movie_detail_screen.dart';
import 'package:transparent_image/transparent_image.dart';

class MovieItemWidget extends StatelessWidget {

  final Movie movie;

  const MovieItemWidget({required this.movie});

  @override
  Widget build(BuildContext context) {
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
