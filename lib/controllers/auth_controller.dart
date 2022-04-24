import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies_app/controllers/genre_controller.dart';
import 'package:movies_app/screens/welcome_screen.dart';

class AuthController extends GetxController {
  final genreController = Get.put(GenreController());
  var isLoggedIn = false.obs;

 @override
  void onInit() {
    genreController.getGenres();
    redirect();
    super.onInit();
  }

  Future<void> redirect() async {

   var token = await GetStorage().read('login_token');

   if(token != null) {
     isLoggedIn.value = true;
   }

   Get.off(() => WelcomeScreen());

  }

}