import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/auth_controller.dart';

class SplashScreen extends StatelessWidget {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Movies App', style: TextStyle(fontSize: 20, color: Colors.white)),
            SizedBox(height: 10,),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

}