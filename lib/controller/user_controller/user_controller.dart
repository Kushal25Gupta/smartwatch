import 'package:get/get.dart';

class UserController extends GetxController {
  var userName = 'User'.obs;
  var userEmail = 'No Email'.obs;
  var userPhotoUrl = 'https://via.placeholder.com/150'.obs;

  void updateUser(String name, String email, String photoUrl) {
    userName.value = name;
    userEmail.value = email;
    userPhotoUrl.value = photoUrl;
  }
}