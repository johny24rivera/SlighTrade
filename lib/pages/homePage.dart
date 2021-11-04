import 'package:flutter/material.dart';
import 'package:slightrade/elements.dart';
import 'package:slightrade/objects/wallet.dart';

import '../objects/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key, required this.user}) : super(key: key);

  final User user;
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
                child: Earnings(
                  wallet: widget.user.getWallet()
                )
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
  const Earnings({ Key? key, required this.wallet }) : super(key: key);

  final Wallet wallet;
  @override
  _EarningsState createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  User user = getPracticeUser();
  Text _portfolioText = Text("");
  Text _earningText = Text("");
  late double portfolio;
  late double earnings;

  @override
  void initState() {
    super.initState();
    widget.wallet.getPortfolio()
      .then((value) => portfolio = value);
    widget.wallet.getEarnings()
      .then((value) => earnings = value);

    setState(() {});
  }

  Future<void> getTexts() async {

    if (earnings < 0) {
      _portfolioText = generateText(portfolio.toString(), Colors.red);
      _earningText = generateText(earnings.toString(), Colors.red);
    } else if (earnings > 0) {
      _portfolioText = generateText(portfolio.toString(), Colors.green);
      _earningText = generateText(earnings.toString(), Colors.green);
    } else {
      _portfolioText = Text(portfolio.toString());
      _earningText = Text(earnings.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    getTexts();

    return Column (
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