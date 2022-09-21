import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_demo/auth/SigninPage.dart';
import 'package:google_map_demo/dashboard.dart';
import 'package:google_map_demo/auth/profile.dart';
import 'package:google_map_demo/main.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'package:google_map_demo/model/user_model.dart';
 class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
   late DatabaseReference _databaseReference;
   Position? location;

  _firebaseInitialize()async{
    FirebaseApp firebaseApp =await Firebase.initializeApp();

    return firebaseApp;
  }
  bool loginWithEmail = true;
  String loginWithSectedSection = "Login With ";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController registerController = TextEditingController();
   getLocation()async{
     location = await Geolocator.getCurrentPosition();

     setState(() {

     });
     print(location);
   }


  @override
  void initState() {
    _databaseReference = FirebaseDatabase.instance.ref().child("Users");
    super.initState();
    print("test");
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: _firebaseInitialize(),
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.done)
              ListView(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Write your name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: loginWithEmail ? emailSection() : phoneSection(),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        loginProviderToggle();
                      },
                      child: Text(
                        loginWithSectedSection +
                            (loginWithEmail ? "Phone Number" : "Email"),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    alignment: Alignment.topRight,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Enter Your Password"),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: Icon(Icons.visibility)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Password Confirmation"),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: Icon(Icons.visibility)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      //controller: registerController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Registered by',
                      ),
                    ),
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Registration'),
                        onPressed: () {
                          registration();
                        },
                      )),
                  Row(
                    children: <Widget>[
                      const Text('Already have an account?'),
                      TextButton(
                        child: const Text(
                          'login',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.g_mobiledata), label: Text("Singin With Google",
                  style: TextStyle(backgroundColor: Colors.red),
                  )),
                  ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.facebook), label: Text("Singin With Facebook"))
                ],
              );
            return  ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Write your name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: loginWithEmail ? emailSection() : phoneSection(),
                ),
                Container(
                  child: TextButton(
                    onPressed: () {
                      loginProviderToggle();
                    },
                    child: Text(
                      loginWithSectedSection +
                          (loginWithEmail ? "Phone Number" : "Email"),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  alignment: Alignment.topRight,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Enter Your Password"),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.visibility)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Password Confirmation"),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.visibility)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: registerController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Registered by',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Registration'),
                      onPressed: () {
                        registration();
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Already have an account?'),
                    TextButton(
                      child: const Text(
                        'login',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.g_mobiledata), label: Text("Singin With Google",
                  style: TextStyle(backgroundColor: Colors.red),
                )),

              ],
            );
          },
        ));
  }

  Widget emailSection() {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Enter Your Email"),
        prefixIcon: Icon(Icons.email),
      ),
    );
  }

  Widget phoneSection() {
    return TextField(
      controller: phoneController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        label: Text("Enter Your Phone"),
        prefixIcon: Icon(Icons.phone),
      ),
    );
  }

  loginProviderToggle() {
    if (loginWithEmail)
      loginWithEmail = false;
    else
      loginWithEmail = true;
    setState(() {});
  }

   singinWithGoogle(){
     ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.g_mobiledata), label: Text("Singin With Google"));
   }
   singinWithFacebook(){

     ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.facebook), label: Text("Singin With Facebook"));
   }


  registration() async{
    String name = nameController.text.toString();
    String phoneNumber = phoneController.text.toString();
    String userEmail = emailController.text.toString();
    String userPassword = passwordController.text.toString();
    String registeredBy = registerController.text.toString();

    if(name.length<5 && phoneNumber.length<10 && userEmail.length<13 && userPassword.length <6){

    }else{
      try{
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: userEmail,
            password: userPassword
        );
        User? user = userCredential.user;
        setState(() {
        });
        if(user != null){
          Fluttertoast.showToast(
              msg: "Registration Success",
                  backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,


          );
          print("registration Success");
          UserModel userModel = UserModel();
          userModel.uid = user.uid;
          userModel.name = name;
          userModel.lat = location!.latitude.toString();
          userModel.lon = location!.longitude.toString();
          userModel.phoneNumber = phoneNumber;
          userModel.userEmail = userEmail;
          userModel.userPassword = userPassword;
          userModel.registeredBy = registeredBy;


          Map<String,String> users = {
            'uid':user.uid,
            'name':name,
            'lat':location!.latitude.toString(),
            'lon':location!.longitude.toString(),
            'phoneNumber':phoneNumber,
            'userEmail':userEmail,
            'userPassword':userPassword,
            'registeredBy':registeredBy,
          };
          _databaseReference.child(user.uid).set(users);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));

        }else{
          Fluttertoast.showToast(
            msg: "Something is wrong",
            backgroundColor: Colors.red,
            gravity: ToastGravity.TOP,
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 3,
          );
          print("Something is wrong");
        }
      }catch(e){
        print(e.toString());
      }
    }
}
}