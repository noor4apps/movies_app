import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/constants/m_colors.dart';
import 'package:movies_app/constants/sizes.dart';
import 'package:movies_app/controllers/movie_controller.dart';
import 'package:movies_app/models/actor.dart';
import 'package:movies_app/widgets/movie_item_widget.dart';

class ActorScreen extends StatefulWidget {

  final Actor actor;

  const ActorScreen({required this.actor});

  @override
  _ActorScreenState createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {

  final movieController = Get.find<MovieController>();

  @override
  void initState() {
    movieController.getMovies(actorId: widget.actor.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return ListView(
          children: [
            buildTopBanner(actor: widget.actor),
            SizedBox(height: 10),
            buildMovies()
          ],
        );
      }),
    );
  }

  Widget buildTopBanner({required Actor actor}) {
    return Container(
      height: Get.height/3,
      child: Stack(
        children: [
          Image.network('${actor.image}', fit: BoxFit.cover, width: double.infinity, height: double.infinity),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(color: Colors.black.withOpacity(0)),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: MColors.primary,
                      radius: 75,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage('${actor.image}'),
                      radius: 70,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text('${actor.name}', style: TextStyle(fontSize: Sizes.actorDetail)),
              ],
            ),
          ),
          IconButton(
            padding: EdgeInsets.all(15),
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, size: 30),
          )
        ],
      ),
    );
  }

  Widget buildMovies() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Movies', style: TextStyle(fontSize: Sizes.section)),
          SizedBox(height: 10),
          movieController.isLoading.value
              ? Container(height: Get.height/2, child: Center(child: CircularProgressIndicator()))
              : ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MovieItemWidget(movie: movieController.movies[index]),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: movieController.movies.length,
                ),
        ],
      ),
    );
  }

}
