import 'package:hive/hive.dart';

import '../model/usermodel.dart';

class DBfunction{
  DBfunction.internal();
  static DBfunction instance=DBfunction.internal();
  factory DBfunction(){
    return instance;

  }

 Future<void> usersignup(user userr)async {
    final db= await Hive.openBox<user>('user');
    db.put(userr.id,userr);
 }
 Future<List<user>>Getuser()async{
    final db=await Hive.openBox<user>('user');
    return db.values.toList();
 }
}