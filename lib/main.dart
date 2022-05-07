import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies_app/controllers/movie_controller.dart';
import 'package:movies_app/screens/splash_screen.dart';
import 'package:movies_app/services/api.dart';
import 'package:movies_app/constants/m_colors.dart';

void main() async {
  await GetStorage.init();
  Api.initializeInterceptors();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Get.create(() => MovieController());

    return GetMaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          iconTheme: IconThemeData(color: MColors.white, size: 27),
          backgroundColor: MColors.tertiary,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: MColors.secondary,
            statusBarIconBrightness: Brightness.light,
          ),
          titleTextStyle: TextStyle(
            color: MColors.white,
            fontSize: 20,
          ),
          // iconTheme: IconThemeData(color: Colors.black),
          // color: Colors.blue
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: MColors.primary,
          secondary: MColors.secondary,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.dark,
      // translations: Translation(),
      locale: Locale('en'), //Get.deviceLocale
      fallbackLocale: Locale('en'),
      defaultTransition: Transition.fade,
      transitionDuration: Duration(milliseconds: 100),
      home: SplashScreen(),
    );
  }
}
