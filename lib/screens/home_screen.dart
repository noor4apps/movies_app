import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children:<Widget>[
                buildLandscapeMovieList()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLandscapeMovieList() {
    return Column(
      children:<Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:<Widget>[
            Text('Now Playing', style: TextStyle(fontSize: 20, color: Colors.green),),
            Text('Show All...', style: TextStyle(color: Colors.lightGreen),),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 255,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return buildLandscapeMovieCard();
            },
            separatorBuilder: (context, index) {return SizedBox(width: 10);},
            itemCount: 3,
          ),
        )
      ],
    );
  }

  buildLandscapeMovieCard() {
    return Container(
      height: double.infinity,
      width: 340,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children:<Widget>[
            Image.network(
              'http://www.impawards.com/2009/posters/avatar_ver6.jpg',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Movie Name', style: TextStyle(fontSize: 18, color: Colors.green), overflow: TextOverflow.ellipsis, maxLines: 1),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star, color: Colors.yellow),
                      Text('7.5', style: TextStyle(fontSize: 18, color: Colors.lightGreen))
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
