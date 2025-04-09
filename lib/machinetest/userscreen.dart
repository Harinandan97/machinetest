import 'package:flutter/material.dart';
import 'package:for_test/machinetest/usercontroller.dart';
import 'package:for_test/machinetest/usertile.dart';
import 'package:get/get.dart';

import 'details.dart';

class UserListScreen extends StatelessWidget {
  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
            onRefresh: controller.fetchUsers,
            child: ListView.builder(
              itemCount: controller.userList.length,
              itemBuilder: (context, index) {
                final user = controller.userList[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => UserDetailScreen(user: user));
                  },
                  child: UserTile(user: user),
                );
              },
            ),
          );
        }
      }),
    );
  }
}