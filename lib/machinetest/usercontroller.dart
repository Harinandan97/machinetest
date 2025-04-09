import 'package:for_test/machinetest/service.dart';
import 'package:get/get.dart';

import 'model.dart';


class UserController extends GetxController {
  var isLoading = true.obs;
  var userList = <UserModel>[].obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading(true);
      var users = await UserService.fetchUsers();
      users.sort((a, b) => a.address.city.compareTo(b.address.city));
      userList.value = users;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load users');
    } finally {
      isLoading(false);
    }
  }
}