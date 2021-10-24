import 'dart:html';

import 'package:flutter/material.dart';
import 'package:slightrade/elements.dart';

import '../objects/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home")
      ),
      body:
        Center(
          child: Column(
            children: [
              Container( 
                padding: EdgeInsets.all(20),
                child: Earnings()
              ), //Earning or Loss Container
              Container(

              ), 
            ],
          )
        )
    );
  }
}

class Earnings extends StatefulWidget {
  const Earnings({ Key? key }) : super(key: key);

  @override
  _EarningsState createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  User user = getPracticeUser();
  double _earning = 0;
  double _portfolio = 0;
  late Text _portfolioText;
  late Text _earningText;

  void getTexts() {

    if (_earning < 0) {
      _portfolioText = generateText(_portfolio.toString(), Colors.red);
      _earningText = generateText(_earning.toString(), Colors.red);
    } else if (_earning > 0) {
      _portfolioText = generateText(_portfolio.toString(), Colors.green);
      _earningText = generateText(_earning.toString(), Colors.green);
    } else {
      _portfolioText = Text(_portfolio.toString());
      _earningText = Text(_earning.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    getTexts();

    return Column(
      children: [
        Row(
          children: [
            Text("Portfolio: "),
            _portfolioText,
          ],
        ),
        Row(
          children: [
            Text("Earnings: "),
            _earningText,
          ],
        )
      ],
    );
  }
}