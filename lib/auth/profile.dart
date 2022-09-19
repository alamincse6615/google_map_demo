import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/ui/firebase_list.dart';
import 'package:flutter/material.dart';
import 'package:google_map_demo/auth/SigninPage.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? captureImage;
  User? user;

  var currentUser;
  late DatabaseReference _databaseReference;

  Query dataQuery = FirebaseDatabase.instance.ref().child("Users");

  String uid = "";

  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.ref().child("Users");
    super.initState();
    _firebaseInitialize();
    FirebaseAuth auth = FirebaseAuth.instance;
    if(auth.currentUser==null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }else{
      uid = auth.currentUser!.uid.toString();
      getUserData(auth.currentUser!.uid);
    }


  }
  void getUserData(id)async{
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('Users/$id').get();
    if (snapshot.exists) {
      currentUser = snapshot.value;
      setState(() {

      });

    } else {
      print('No data available.');
    }
  }


    _firebaseInitialize()async{
    FirebaseApp firebaseApp =await Firebase.initializeApp();
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(currentUser['name']+"'s profile"),
        ),
        body: currentUser!=null?SingleChildScrollView(
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Center(
                            child: CircleAvatar(
                              maxRadius: 150,
                              child: captureImage == null
                                  ? CircleAvatar(
                                maxRadius: 150,
                                backgroundImage: AssetImage("images/download.png"),
                              )
                                  : CircleAvatar(
                                maxRadius: 150,
                                backgroundImage: FileImage(
                                  captureImage!,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 80,
                            bottom:5,
                            child: TextButton.icon(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: MediaQuery.of(context).size.height/6,
                                          width: MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              FlatButton.icon(
                                                  onPressed: () {
                                                    imagecamera();
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(Icons.camera),
                                                  label:
                                                  Text("Camera")),
                                              FlatButton.icon(
                                                  onPressed: () {
                                                    ImageFile();
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(Icons.memory),
                                                  label:
                                                  Text("Memory"))
                                            ],
                                          ),
                                          // child: Text("Select Your Profile Picture"),
                                        );
                                      });
                                },
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.red,
                                ),
                                label: Text("")),
                          ),
                        ],

                      ),
                    ),
                  ),

                  TextInputField(),
                  SaveButton(),
                ]
            )
        ):Center(child: CircularProgressIndicator())
    );

  }

  imagecamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      captureImage = File(image.path);
      setState(() {});
    }
  }
  ImageFile() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      captureImage = File(image.path);
      setState(() {});
    }
  }
  TextInputField() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
           currentUser['name']
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
              currentUser['userEmail']
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
              currentUser['userEmail']
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(currentUser['lat']+""+currentUser['lon']),
              TextButton.icon(
                  onPressed: () {}, icon: (Icon(Icons.edit)), label: Text(""))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 150,
            color: Colors.red,
          ),
        )
      ],
    );
  }
  SaveButton() {
    return ElevatedButton.icon(
        onPressed: () {}, icon: (Icon(Icons.save)), label: Text("Save"));
  }

}


