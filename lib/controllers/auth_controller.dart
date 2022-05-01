import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movies_app/controllers/base_controller.dart';
import 'package:movies_app/controllers/genre_controller.dart';
import 'package:movies_app/models/user.dart';
import 'package:movies_app/responses/user_response.dart';
import 'package:movies_app/screens/welcome_screen.dart';
import 'package:movies_app/services/api.dart';

class AuthController extends GetxController with BaseController {
  final genreController = Get.put(GenreController());

  var user = User().obs;
  var isLoggedIn = false.obs;

  @override
  void onInit() async {
    await genreController.getGenres();
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

  Future<void> login({required Map<String, dynamic> loginData}) async {
    showLoading();

    var response = await Api.login(loginData: loginData);
    var userResponse = UserResponse.fromJson(response.data);

    await GetStorage().write('login_token', userResponse.token);

    user.value = userResponse.user;

    isLoggedIn.value = true;

    hideLoading();

    Get.offAll(() => WelcomeScreen());
  }

  Future<void> logout() async {
    await Api.logout();
    await GetStorage().remove('login_token');
    isLoggedIn.value = false;
    Get.offAll(() => WelcomeScreen());
  }

}