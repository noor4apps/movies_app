import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/constants/m_colors.dart';
import 'package:movies_app/constants/sizes.dart';
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
      color: MColors.primary,
      child: Center(
        child: Text('Settings', style: TextStyle(fontSize: Sizes.screen)),
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
                    Get.to(() => FavoriteScreen(title: 'Favorite'), preventDuplicates: false);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    Get.defaultDialog(
                        title: "Confirm Logout",
                        textConfirm: "Confirm",
                        textCancel: "Cancel",
                        radius: 50,
                        content: Text('Are you sure want to Logout?'),
                        onConfirm: () {
                          authController.logout();
                        });
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
