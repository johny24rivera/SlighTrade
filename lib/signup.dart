import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:slightrade/login.dart';
import 'package:slightrade/myHomePage.dart';
import 'package:slightrade/elements.dart';
import 'package:slightrade/user.dart';

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
  late String username;
  late String email;
  late String password;
  late String confirmPassword;

  void click() {
    this.username = usernameController.text;
    this.email = emailController.text;
    this.password = passwordController.text;
    this.confirmPassword = confirmPasswordController.text;

    User member = new User(username, email, password);

    String jsonMember = jsonEncode(member.toJson());

    // verify password == confirmPassword
    // store email, username & hashed password

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(title: jsonMember)
      )
    );
  }

  void login() {
    Navigator.push(
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