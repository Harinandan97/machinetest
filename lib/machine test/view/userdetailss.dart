import 'package:flutter/material.dart';

import '../model/details model.dart';


class UserDetailScreen extends StatelessWidget {
  final Userinfo user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.yellow[100],
      appBar: AppBar(title: Text(user.username)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email: ${user.email}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("City: ${user.address.city}"),
            Text("Street: ${user.address.street}"),
            Text("Number: ${user.address.number}"),
            Text("Zipcode: ${user.address.zipcode}"),
          ],
        ),
      ),
    );
  }
}