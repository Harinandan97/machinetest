import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:for_test/firebaseee/register.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import '../firebase_options.dart';
import 'home.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(GetMaterialApp(home: newlogin(),));
}

class newlogin extends StatefulWidget {
  const newlogin({super.key});

  @override
  State<newlogin> createState() => _newloginState();
}

class _newloginState extends State<newlogin> {

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  GlobalKey<FormState>formkeyy=GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void>login()async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => newhome()));
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("login erorr: ${e.toString()}")));
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("login page"),),
      body:
      Form(
        key: formkeyy,
        child: Column(
          children: [
            SizedBox(height: 30),

            TextFormField(
              controller: email,
              decoration: InputDecoration(
                  hintText: "Email",labelText: "Email",icon: Icon(Icons.email),border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
              ),
              validator:(email){
                if(email!.isEmpty){
                  return"email canot be empty ";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 30,),
            TextFormField(
              controller: password,
              decoration: InputDecoration(labelText: "password",hintText: "password",icon: Icon(Icons.password_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
              ),
              validator: (password){
                if(password!.isEmpty){
                  return"password canot be empty ";
                }
                else{
                  return null;
                }
              },
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed:() {
              var valid=formkeyy.currentState!.validate();

              if(valid){
                login();
              }

            }, child: Text("Login")),
            SizedBox(height: 10,),
            TextButton(onPressed: (){
              Navigator.push((context), MaterialPageRoute(builder: (context)=>newresister()));
            }, child: Text("not a user"))
          ],
        ),
      ),
    );
  }
}
