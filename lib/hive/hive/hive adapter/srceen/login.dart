import 'package:flutter/material.dart';
import 'package:for_test/hive/hive/hive%20adapter/srceen/register.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../database/database.dart';
import '../model/usermodel.dart';
import 'home.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(userAdapter());
  Hive.openBox<user>('user');
  runApp(GetMaterialApp(home: hivelogin(),));

}
class hivelogin extends StatefulWidget {
  const hivelogin({super.key});

  @override
  State<hivelogin> createState() => _hiveloginState();
}

class _hiveloginState extends State<hivelogin> {

  @override
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController confirmpassword=TextEditingController();
  GlobalKey<FormState>formkey1=GlobalKey();
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Form(
        key: formkey1,
        child: Column(
          children: [
            SizedBox(height: 50,),
            TextFormField(
              controller: email,
              decoration:
             InputDecoration(
               hintText: 'email',
                 labelText: "email",
               prefixIcon: Icon(Icons.email),
                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
             ) ,
              validator: (email){
                if(email!.isEmpty||!email.contains("@")||!email.contains(".")){
                  return"pls entre a valid Email  name ";
                }
                else{
                  return null;
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30,bottom: 30),
              child: TextFormField(
                controller: password,
                decoration: InputDecoration(
                hintText: "password",
                labelText: "password",
                prefixIcon: Icon(Icons.password),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
              ),
                  validator: (password){
                    if(password!.isEmpty||password.length<6){
                      return "pls enter valid password";
                    }
                    return null;
                  },
              ),

            ),
            TextFormField(
              controller: confirmpassword,
              decoration: InputDecoration(
              labelText: "confirm password",
              hintText: "confirm password",
              prefixIcon: Icon(Icons.password_outlined),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
            ),
              validator: (password){
                if(password!.isEmpty||password.length<6){
                  return "pls enter valid password";
                }
                return null;
              },
            ),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: ()async{
              final userlist=await DBfunction.instance.Getuser();
              finduser(userlist);
            }, child: Text('login')),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>regx()));
            }, child: Text("not a user"))
          ],
        ),
      ),
    );
  }

  void finduser(List<user> userlist) async{
    final emaill = email.text.trim();
    final pass =password.text.trim();

    bool userFound = false;
    final validate = await validateLogin(emaill,pass);

    if(validate == true){
      await Future.forEach(userlist, (user){
        if(user.email == emaill && user.password == pass){
          userFound = true;
        }else{
          userFound = false;
        }
      });
      if(userFound==true){
        Get.offAll(()=> homhi(email: emaill));
        Get.snackbar("success", "login success",backgroundColor: Colors.green);
      }else{
        Get.snackbar("error", "Incorrect email/password",backgroundColor: Colors.red);
      }
    }


  }

 Future<bool> validateLogin(String emaill, String pass)async {
    if(emaill !=' ' && pass!=''){
      return true;
    }else{
      Get.snackbar("error", "feilds can not br empty",backgroundColor: Colors.red);
      return false;
    }
 }
}
