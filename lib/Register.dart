import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internship/Register.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20),bottom: Radius.circular(20))
                      ),
                      margin: EdgeInsets.only(top:60,left: 30,right: 30,bottom: 10),
                      padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                      child: TextFormField(
                        controller: userNameController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.mail),
                            hintText: "Enter your username"
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20),bottom: Radius.circular(20))
                      ),
                      margin: EdgeInsets.only(top:30,left: 30,right: 30,bottom: 10),
                      padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                      child: TextFormField(
                        controller: emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email)=>
                        email == null? "Wrong email": null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.mail),
                            hintText: "Enter your email"
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20),bottom: Radius.circular(20))
                      ),
                      margin: EdgeInsets.all(30),
                      padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                      child: TextFormField(
                        controller: passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (password)=>
                        password != null && password.length > 6 ?  null:"password will be more than 6 charachter",
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.password),
                            hintText: "Enter your password"
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            signUp();
                          },
                          child: Text('Register',style: TextStyle(
                              fontSize: 20
                          ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
  Future signUp() async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
    ).then((value) => FirebaseFirestore.instance.collection("users").doc(value.user?.uid)
        .set({
      "email": value.user?.email,
      "userName": value.user?.email,},
    ),);
    Navigator.of(context).pop();
  }
}

