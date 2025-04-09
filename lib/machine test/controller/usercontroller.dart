import 'package:get/get.dart';

import '../model/details model.dart';
import '../service/detailsservice.dart';


class UserController extends GetxController {
  var isLoading = true.obs;
  var userList = <Userinfo>[].obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      var users = await httpservice.fetcusers();
      users.sort((a, b) => a.address.city.compareTo(b.address.city));
      userList.value = users;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load users');
    } finally {
      isLoading(false);
    }
  }
}