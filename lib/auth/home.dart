import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_map_demo/auth/regestration.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var userEmail= "" ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseInitialize();
    geDataFromFirebase();
  }

  _firebaseInitialize()async{
    FirebaseApp firebaseApp =await Firebase.initializeApp();
    return firebaseApp;
  }
  geDataFromFirebase(){
   FirebaseAuth auth = FirebaseAuth.instance;
   userEmail = auth.currentUser!.email!;






  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: ElevatedButton(
          child: Text(userEmail),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationPage()));
          },
        ),
      ),

    );
  }
}
