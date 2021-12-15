import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:slightrade/helpful-methods/formValidation.dart';
import 'package:slightrade/login.dart';
import 'package:slightrade/elements.dart';
import 'package:slightrade/objects/user.dart';
import 'package:slightrade/pages/setup_pages/wallet_setup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup Page"),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({ Key? key }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  late String username;
  late String email;
  late String password;
  late String confirmPassword;

  bool missingFields() {
    if (username == '' || email == '' || password == '') {
      return true;
    }
    return false;
  }

  bool emailUsed(email) {
    final document = FirebaseFirestore.instance
      .collection('users')
      .where('_email', isEqualTo: email)
      .get()
      .then((value) {return true;});
    
    return false;
  }

  bool verifyUserData(email, username) {
    // make sure username is not used
    // make sure is not used;
    // verify email is valid

    if (missingFields()) {
      generateAlert("Invalid Input", "There is a field missing.", context);
      return false;
    }

    if (password != confirmPassword) {
      generateAlert("Invalid Input", "Passwords do not match", context);
      return false;
    }

    if (emailUsed(email)){
      generateAlert("Invalid Input", "Email is already in use", context);
      return false;
    }



    return true;
  }

  void click() {
    this.username = usernameController.text;
    this.email = emailController.text;
    this.password = passwordController.text;
    this.confirmPassword = confirmPasswordController.text;

    // Go to Home page if all information is correct
    if (verifyUserData(email, username)) {
      this.password = hashPassword(password);
      User member = new User.withoutWallet(username, email, password);
      String jsonMember = jsonEncode(member.toJson());
      print(jsonMember);

      users.add(member.toJson())
        .then((value) {
          value.update({'_id':value.id});
          member.setId(value.id);
          print("User Added");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => WalletPage(user: member)
              // builder: (context) => HomePage()
            )
          );
          }
        )
        .catchError((error) => print("Failed to add user: $error"));

    }
  }

  void login() {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => LoginPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> elements = <Widget>[
      generateTextField(usernameController, "username", Icon(Icons.person)),
      generateTextField(emailController, "E-mail", Icon(Icons.email)),
      generateTextField(passwordController, "Password", Icon(Icons.lock), true),
      generateTextField(confirmPasswordController, "Confirm Password", Icon(Icons.lock), true),
      generateButton(click),
      generateLink(login, "Already have an account? Sign in Here."),
    ];

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: elements,
        )
      )
    );
  }
}