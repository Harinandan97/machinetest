import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/details model.dart';

class UserTile extends StatelessWidget {
  final Userinfo user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 3,
      child: ListTile(
        title: Text(user.username.toString()),
        subtitle: Text(user.address.city),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}