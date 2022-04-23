import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies_app/screens/welcome_screen.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

 @override
  void onInit() {
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