import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  List<UserModel> userList = [];


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
      appBar: AppBar(title: Text("User List"),),
      body: ListView(
        children: [
          Center(
            child: ElevatedButton(
              child: Text("Sign Up"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationPage()));
              },
            ),
          ),
          Container(
            height: userList.length*80,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: userList.length,
                itemBuilder: (context,index){
                  return ListTile(
                    leading: Icon(Icons.person),
                    trailing: Icon(userList[index].phoneNumber.toString().length>5?Icons.phone:Icons.email),
                    title: Text(userList[index].name.toString()),
                    subtitle: Text(
                        userList[index].phoneNumber.toString().length>5?userList[index].phoneNumber.toString():userList[index].userEmail.toString()
                    ),
                    onTap: (){
                      userList[index].phoneNumber.toString().length>5?openDialPad(userList[index].phoneNumber.toString()):openGmail(userList[index].userEmail.toString());

                    },
                  );
                }
            ),
          ),
        ],
      ),

    );
  }
  openGmail(email){
    showToast(email);
    /// go to gmail
  }

  openDialPad(phone){
    showToast(phone);
    /// go to dialpad
  }

  showToast(toastmsg){
    Fluttertoast.showToast(
      msg:toastmsg,
      backgroundColor: Colors.red,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 3,
    );
  }
}
