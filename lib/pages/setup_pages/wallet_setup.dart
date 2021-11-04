import 'package:flutter/material.dart';
import 'package:slightrade/elements.dart';
import 'package:slightrade/objects/funds.dart';
import 'package:slightrade/objects/user.dart';
import 'package:slightrade/pages/homePage.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({ Key? key, required this.user }) : super(key: key);

  final User user;

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  TextEditingController fundController = new TextEditingController();
  

  void click() {
    double initial = double.parse(fundController.text);
    widget.user.getWallet().setFunds(Funds.withInitial(initial));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(user: widget.user)
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> elements = <Widget>[
      generateTextField(fundController, "Initial Funds", Icon(Icons.money)),
      generateButton(click),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Fund Setup")
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20), 
          child: Column(
            children: elements,
          ),
        ),
      )
    );
  }
}