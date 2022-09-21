import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_map_demo/auth/regestration.dart';
import 'package:google_map_demo/model/user_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var userEmail= "" ;

  late UserModel _userModel;
 var allUser;
  int dataLength = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseInitialize();
    getUserData();
  }

  _firebaseInitialize()async{
    FirebaseApp firebaseApp =await Firebase.initializeApp();
    return firebaseApp;
  }
  void getUserData()async{
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Users').get();
    if (snapshot.exists) {
      allUser = snapshot.value;

      setState(() {

      });


    } else {
      print('No data available.');
    }








  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: ElevatedButton(
          child: Text("Sign Up"),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationPage()));
          },
        ),
      ),

    );
  }
}
