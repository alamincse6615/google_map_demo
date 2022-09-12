
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_map_demo/auth/SigninPage.dart';
import 'package:google_map_demo/auth/dashboard.dart';
import 'package:google_map_demo/main.dart';




 class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("test");
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
                      //controller: nameController,
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
                ],
              );
            return  ListView(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    //controller: nameController,
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

  registration() async{
    String name = nameController.text.toString();
    String phoneNumber = phoneController.text.toString();
    String userEmail = emailController.text.toString();
    String userPassword = passwordController.text.toString();
    String registeredBy = registerController.text.toString();
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword
      );
      User? user = userCredential.user;
      setState(() {

      });
      if(user != null){
        print("Login Success");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard()));

      }else{
        print("Something is wrong");
      }
    }catch(e){
      print(e.toString());
    }

    // Navigator.push(context,MaterialPageRoute(builder: (context) => Dashboard()));
  }
}