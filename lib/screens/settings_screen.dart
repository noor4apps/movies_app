import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/auth_controller.dart';
import 'package:movies_app/screens/favorite_screen.dart';
import 'package:movies_app/screens/login_screen.dart';
import 'package:movies_app/screens/register_screen.dart';

class SettingsScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildTopBanner(),
          buildSettingItems(),
        ],
      ),
    );
  }

  Widget buildTopBanner() {
    return Container(
      height: Get.height / 3.5,
      color: Colors.green,
      child: Center(
        child: Text('Settings', style: TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget buildSettingItems() {
    return Container(
        padding: const EdgeInsets.all(12),
        child: authController.isLoggedIn.value == true
          ? Column(
              children: [
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Favorite movies'),
                  onTap: () {
                    Get.to(() => FavoriteScreen(), preventDuplicates: false);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    Get.to(() => null, preventDuplicates: false);
                  },
                ),
              ],
            )
          : Column(
              children: [
                ListTile(
                  leading: Icon(Icons.login),
                  title: Text('Login'),
                  onTap: () {
                    Get.to(() => LoginScreen(), preventDuplicates: false);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person_add),
                  title: Text('Register'),
                  onTap: () {
                    Get.to(() => RegisterScreen(), preventDuplicates: false);
                  },
                ),
              ],
            ),
    );
  }
}
