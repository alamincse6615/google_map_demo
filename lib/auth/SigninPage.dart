import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginWithEmail = true;
  String loginWithSectedSection = "Login With ";
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var textshow =true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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

                obscureText: textshow,
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    label: Text("Enter Your Password"),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            textshow=!textshow;
                          });
                        },
                        icon: Icon(textshow?Icons.visibility:Icons.visibility_off)
                    )
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login',style: TextStyle(fontSize: 26),),
                    onPressed: () {
                      registration();


                    },
                  )
              ),
            ),

            ClipRRect(borderRadius:BorderRadius.circular(10),
              child: Container(
                color: Colors.green,

                /*child: TextButton(
                  child: const Text(
                    'Creat new account',
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>));
                  },
                ),*/

              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget emailSection() {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
        ),
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
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
        ),
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


  registration(){

    String phoneNumber = phoneController.text.toString();
    String email = emailController.text.toString();
    String password = passwordController.text.toString();



    var data = {

      "email" : email,
      "phoneNumber" : phoneNumber,
      "password" : password,

    };

    print(jsonEncode(data));
  }
}
