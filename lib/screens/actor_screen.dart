import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/actor.dart';

class ActorScreen extends StatefulWidget {

  final Actor actor;

  const ActorScreen({required this.actor});

  @override
  _ActorScreenState createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildTopBanner(actor: widget.actor),
        ],
      ),
    );
  }

  Widget buildTopBanner({required Actor actor}) {
    return Container(
      height: 300,
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
                      backgroundColor: Colors.green,
                      radius: 75,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage('${actor.image}'),
                      radius: 70,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text('${actor.name}', style: TextStyle(fontSize: 25)),
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

}
