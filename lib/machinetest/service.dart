import 'dart:convert';
import 'package:http/http.dart' as http;

import 'model.dart';


class UserService {
  static Future<List<UserModel>> fetchUsers() async {
    const url = 'https://fakestoreapi.com/users';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List jsonData = json.decode(response.body);
      return jsonData.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}