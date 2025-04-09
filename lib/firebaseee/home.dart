import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class newhome extends StatelessWidget {
  const newhome({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user =FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title:Text( "Home",),
        actions: [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          }, icon: const Icon(Icons.logout_outlined))
        ],

      ),
      body:Center(
        child: FutureBuilder<DocumentSnapshot>(future: FirebaseFirestore.instance.collection('user').doc(user?.uid).get(),
            builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return const CircularProgressIndicator();
              }
              if(!snapshot.hasData || !snapshot.data!.exists){
                return const Text("No user found");
              }
              var userdata = snapshot.data!.data()as Map<String,dynamic>;
              return Text("welcome, ${userdata['name']?? 'user'}");
            }),
      ) ,
    );
  }
}
