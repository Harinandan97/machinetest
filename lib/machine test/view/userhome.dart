import 'package:flutter/material.dart';
import 'package:for_test/machine%20test/view/userdetailss.dart';
import 'package:for_test/machine%20test/view/userrrtile.dart';
import 'package:get/get.dart';
import '../controller/usercontroller.dart';



class ProductHome extends StatelessWidget {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
        body: Obx(()
    {
      if (userController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return RefreshIndicator(
          onRefresh: userController.fetchUsers,
          child: Card(color: Colors.yellow[100],
            child: ListView.builder(
              itemCount: userController.userList.length,
              itemBuilder: (context, index) {
                final user = userController.userList[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => UserDetailScreen(user: user));
                  },
                  child: UserTile(user: user),
                );
              },
            ),
          ),
        );
      }
    }));
  }
}