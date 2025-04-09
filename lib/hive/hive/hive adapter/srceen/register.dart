import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';



import '../database/database.dart';
import '../model/usermodel.dart';
import 'login.dart';

void main(){
  runApp(MaterialApp(home: regx(),));
}

class regx extends StatefulWidget {
  const regx({super.key});

  @override
  State<regx> createState() => _regxState();
}

class _regxState extends State<regx> {
  TextEditingController name=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController confirmpassword=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: name,
            decoration: InputDecoration(
              hintText: "name",
              labelText: "name",
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextFormField(
            controller:  email,
            decoration: InputDecoration(
              hintText: "email",
              labelText: "email",
              prefixIcon: Icon(Icons.email),
            ),
          ),
          TextFormField(
            controller: password,
            decoration: InputDecoration(
              hintText: "passwordl",
              labelText: "pasword",
              prefixIcon: Icon(Icons.password),
            ),
          ), TextFormField(
            controller: confirmpassword,
            decoration: InputDecoration(
              hintText: "confirm password",
              labelText: "confirm password",
              prefixIcon: Icon(Icons.password),
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            validatesignup();


            }, child: Text("regisert"))
        ],
      ),
    );
  }

  void validatesignup()async {
    final uname= email.text.trim();
    final pass= password.text.trim();
    final cpassword=confirmpassword.text.trim();

    final emailValidationResult = EmailValidator.validate(uname);
    if(uname !=""&& pass!=""&& cpassword!=""){
      if(emailValidationResult==true){
        final passValidationResult = checkpassword(pass,cpassword);

        if(passValidationResult==true){
          final Userr =user(email: uname, password: pass);
          await DBfunction.instance.usersignup(Userr);
          Get.back();
          Get.snackbar("success", "Acount created");
        }

      }else{
        Get.snackbar("error", "validemail");

      }
    }
    else{
      Get.snackbar("Error","feilds can not be empty");
    }

  }

 bool checkpassword(String pass, String cpassword) {
    if(pass== cpassword){
      if(pass.length<6){
        Get.snackbar("error", "password should be > 6");
        return false;
      }else{
        return true;
      }
    }else{
      Get.snackbar('error', "password mismatch");
      return false;
    }
 }
}
