import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? captureImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit"),
        ),
        body: SingleChildScrollView(
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
                                                  },
                                                  icon: Icon(Icons.camera),
                                                  label:
                                                  Text("Camera")),
                                              FlatButton.icon(
                                                  onPressed: () {
                                                    ImageFile();
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
                                  color: Colors.black,
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
        )
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
          child: TextFormField(
            decoration: InputDecoration(labelText: ("Name")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            decoration: InputDecoration(labelText: ("Phone Number")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            decoration: InputDecoration(labelText: ("Email")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Address"),
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
