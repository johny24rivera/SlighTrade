import 'dart:html';

import 'package:flutter/material.dart';
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(title: user)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding( //UserName field
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: this.userController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "Username or email",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 5,
                      style: BorderStyle.solid
                    )
                  ),
                ),
              ),
            ),
            Padding( // Password Field
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: this.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 5,
                      style: BorderStyle.solid
                    )
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: click,
              child: Text("Submit")
            ),
          ],
        )
      )
    );
  }
}