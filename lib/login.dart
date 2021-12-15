import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slightrade/elements.dart';
import 'package:slightrade/helpful-methods/formValidation.dart';
import 'package:slightrade/pages/homePage.dart';
import 'package:slightrade/signup.dart';
import 'myHomePage.dart';
import 'objects/user.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
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
  TextEditingController userController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  late String user;
  late String password;

  Future<String> verifyUser(String user, String password) async {
    print("verify User called");
    String docId = '';
    await FirebaseFirestore.instance
    .collection('users')
    .where('_username', isEqualTo: user)
    .get()
    .then((value) {
      if (value.docs.isNotEmpty) {
        docId = value.docs[0].id;
      }
    });
    print(docId);

    await FirebaseFirestore.instance
    .collection('users')
    .where('_email', isEqualTo: user)
    .get()
    .then((value) {
      if (value.docs.isNotEmpty) {
        docId = value.docs[0].id;
      }
    });
    print(docId);

    return docId;
  }

  void click() async {
    this.user = userController.text;
    this.password = passwordController.text;
    this.password = hashPassword(password);
    String docId = await verifyUser(user, password);
    User member = new User.empty();
    String passwordCheck = '';
    
    if (docId != '') {
      await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .get()
        .then((value) {
          print(value.data());
          member = new User.fromJson(value.data()!);
          passwordCheck = value.data()!['_password'];
          print(passwordCheck);
        });
    } else {
      generateAlert("User not found", "Email or username is invalid", context);
      return;
    }

    if (password == passwordCheck) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user: member)
        )
      );
    } else {
      generateAlert("Entry not valid", "password is invalid", context);
      return;
    }
    
  }

  void signup() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignupPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> elements = <Widget>[
      generateTextField(userController, "Username or email", Icon(Icons.person)),
      generateTextField(passwordController, "password", Icon(Icons.lock), true),
      generateButton(click),
      generateLink(signup, "Don't have an account? Sign up here."),
    ];

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: elements,
        )
      )
    );
  }
}