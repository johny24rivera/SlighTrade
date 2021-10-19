import 'package:flutter/material.dart';
import 'package:slightrade/elements.dart';
import 'package:slightrade/signup.dart';
import 'myHomePage.dart';

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

  void click() {
    this.user = userController.text;
    this.password = passwordController.text;
    // hash password (MD5)
    //Check Credentials

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(title: user)
      )
    );
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