import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('HomeScreen'),
      ),
    );
  }

}