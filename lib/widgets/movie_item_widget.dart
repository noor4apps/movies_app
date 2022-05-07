import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/constants/m_colors.dart';
import 'package:movies_app/constants/sizes.dart';
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
            width: Get.width / 3.5,
            height: Get.height / 4.5,
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
                      child: Text('${movie.title}', style: TextStyle(fontSize: Sizes.titleCart, color: MColors.primary, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis, maxLines: 2),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star, color: MColors.yellow, size: Sizes.starIconCart),
                        Text('${movie.vote}', style: TextStyle(fontSize: Sizes.starNumberCart, color: MColors.secondary))
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  '${movie.description}',
                  style: TextStyle(fontSize: Sizes.descriptionCart, color: MColors.tertiary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 6,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}
