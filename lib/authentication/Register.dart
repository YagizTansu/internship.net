import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final descriptionController = TextEditingController();
  var userType ="choose your type";
  final _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    descriptionController.dispose();
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
                child: Form(
                  key: _formKey,
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
                          validator:(value) {
                            if (value == null || value.isEmpty) {
                            return 'You cannot leave this blank';
                            } else {
                            return null;
                            }
                        },
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
                          validator:(value) {
                            if (value == null || value.isEmpty) {
                              return 'You cannot leave this blank';
                            } else {
                              return null;
                            }
                          },
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
                          validator: (password)=> password != null && password.length > 6 ?  null:"Password will be more than 6 character",
                          obscureText: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.password),
                              hintText: "Enter your password"
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20),bottom: Radius.circular(20))
                        ),
                        margin: EdgeInsets.only(top:5,left: 30,right: 30,bottom: 10),
                        padding: EdgeInsets.only(left: 15,right: 15,top: 5,bottom: 5),
                        child: TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.mail),
                              hintText: "Enter your description"
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 15),
                        child: AwesomeDropDown(
                          isBackPressedOrTouchedOutSide: false,
                          elevation: 5,
                          dropDownBorderRadius: 10,
                          dropDownTopBorderRadius: 50,
                          dropDownBottomBorderRadius: 50,
                          dropDownIconBGColor: Colors.transparent,
                          dropDownOverlayBGColor: Colors.transparent,
                          dropDownBGColor: Colors.white,
                          numOfListItemToShow: 4,
                          selectedItemTextStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          dropDownListTextStyle: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 15,
                              backgroundColor: Colors.transparent),
                          isPanDown: false,
                          selectedItem: userType,
                          dropDownList: ['intern','company'],
                          dropDownIcon: Icon(Icons.work_outline_outlined),
                          onDropDownItemClick: (item) {
                            setState(() {
                              userType = item;
                            });
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if(_formKey.currentState!.validate()){
                                signUp();
                              }
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
      "userEmail": value.user?.email,
      "userName": userNameController.text,
      "userType": userType,
      "userDescription": descriptionController.text
    },
    ),);
    Navigator.of(context).pop();
  }
}

