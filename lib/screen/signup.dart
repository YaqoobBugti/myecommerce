import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:myecommerce/screen/login.dart';
import '../Wiget/my_textfield.dart';
import '../Wiget/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  static Pattern patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool lodding = false;
  final _auth = FirebaseAuth.instance;
  UserCredential authResult;
  RegExp regex = RegExp(SignUp.pattern);
  RegExp regExp = RegExp(SignUp.patttern);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();

  void function() {
    if (fullname.text.isEmpty && email.text.isEmpty && password.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('All field is emtpy'),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
      return;
    } else if (fullname.text.trim().isEmpty || fullname.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Full Name is empty'),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
      return;
    } else if (email.text.trim().isEmpty || email.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Email is empty'),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
      return;
    } else if (!regex.hasMatch(email.text)) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Please Enter Valid Email'),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
      return;
    }
    if (password.text.trim().isEmpty || password.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Password is empty'),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
      return;
    } else if (password.text.length < 8) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Password is too short'),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
    }
    if (phone.text.trim().isEmpty || phone.text.trim() == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Phone is empty'),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
      return;
    } else if (phone.text.length > 11) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Phone Must be Eleven'),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
    } else {
      authcation();
    }
  }

  Future authcation() async {
    try {
      authResult = await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      await FirebaseFirestore.instance
          .collection('user')
          .doc(authResult.user.uid)
          .set(
        {
          'userid': authResult.user.uid,
          "password": password.text,
          "Email": email.text,
          'FullName': fullname.text,
          'PhoneNumber': phone.text,
        },
      );
    } on PlatformException catch (err) {
      var massage = "An error occurred ,please check your credentials";
      if (err.message != null) {
        massage = err.message;
      }
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(massage),
          backgroundColor: Theme.of(context).accentColor,
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Signup",
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      MYTextField(
                        hintText: "Full Name",
                        controller: fullname,
                        obscuretext: false,
                        keyboard: TextInputType.text,
                      ),
                      MYTextField(
                        hintText: "Email",
                        controller: email,
                        obscuretext: false,
                        keyboard: TextInputType.emailAddress,
                      ),
                      MYTextField(
                        eyeicon: Icons.remove_red_eye,
                        hintText: "Password",
                        controller: password,
                        obscuretext: true,
                        keyboard: TextInputType.visiblePassword,
                      ),
                      MYTextField(
                        eyeicon: null,
                        hintText: "Phone",
                        controller: phone,
                        obscuretext: false,
                        keyboard: TextInputType.phone,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Button(
                        buttoncolors: Theme.of(context).textSelectionColor,
                        textcolor: Colors.white,
                        tittle: 'Sign Up',
                        whenpress: () {
                          function();
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Already have a account?  '),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            child: Text(
                              "SignIn",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
