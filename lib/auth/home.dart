import 'dart:collection';
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
  List<UserModel> userList = [];


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
    FirebaseDatabase.instance.ref("Users").onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map,);
      data.forEach((key, value) {
        _userModel = UserModel.fromJson(value);
        userList.add(_userModel);
      });
      setState(() {
        print(userList);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Users"),
      ),
      body: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Colors.black.withOpacity(.3),
                title: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 10,),
                    Text(userList[index].name.toString()),
                  ],
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email_outlined),
                        SizedBox(width: 10,),
                        Text(userList[index].userEmail.toString()),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.call),
                        SizedBox(width: 10,),
                        Text(
                            userList[index].phoneNumber.toString().length>10?userList[index].phoneNumber.toString():"Not Found",
                            style: TextStyle(
                              color:  userList[index].phoneNumber.toString().length>10?Colors.green:Colors.red
                            ),

                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );

      }
      )

    );
  }
}
