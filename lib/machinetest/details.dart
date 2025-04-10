import 'package:flutter/material.dart';

import 'model.dart';


class UserDetailScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Email: ${user.email}"),
              Text("City: ${user.address.city}"),
              Text("Street: ${user.address.street}"),
              Text("Number: ${user.address.number}"),
              Text("Zipcode: ${user.address.zipcode}"),


            ],
          ),
        ),
      ),
    );
  }
}

//