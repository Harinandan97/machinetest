import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class newresister extends StatefulWidget {
  const newresister({super.key});

  @override
  State<newresister> createState() => _newloginState();
}

class _newloginState extends State<newresister> {

  final TextEditingController email=TextEditingController();
  final TextEditingController password=TextEditingController();
  final TextEditingController name=TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> register()async{
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
      await firestore.collection('user').doc(userCredential.user!.uid).set({
        'name':name.text.trim(),
        'email':email.text.trim(),
        'password':password.text.trim(),
        'createdAt':FieldValue.serverTimestamp()

      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registartion successful")));
      Navigator.pop(context);
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Registration error: ${e.toString()}")));
    }
  }

  GlobalKey<FormState>formkeyyy=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("register page"),),
      body:
      Form(
        key: formkeyyy,
        child: Column(
          children: [
            SizedBox(height: 30),
            TextFormField(
              controller: name,
              decoration: InputDecoration(
                  hintText: "username",labelText: "username",icon: Icon(Icons.person),border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
              ),
              validator:(uname){
                if(uname!.isEmpty){
                  return"username canot be empty ";
                }
                else{
                  return null;
                }
              },
            ),

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
            ElevatedButton(onPressed: (){
              var valid=formkeyyy.currentState!.validate();
              if(valid){
                register();
              }
            }, child: Text("register")),


          ],
        ),
      ),
    );
  }
}
