import 'package:http/http.dart' as http;

import '../model/details model.dart';



class httpservice{
  static Future<List<Userinfo>> fetcusers() async{
    var respone =await http.get(Uri.parse("https://fakestoreapi.com/users"));
    if(respone.statusCode ==200){
      var data =respone.body;
      return userinfoFromJson(data);
    }else{
      throw Exception();
    }
  }

}