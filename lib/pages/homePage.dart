import 'dart:convert';

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
  TextEditingController searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var jsonUser = jsonEncode(widget.user.toJson());
    print(jsonUser);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[],
        leading: generateMenuButton(),
      ),
      body:
        Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: generateSearchBar(context, widget.user),
              ),
              Container( 
                padding: EdgeInsets.all(20),
                child: FutureBuilder(
                  future: Future.wait([
                    widget.user.getWallet().getPortfolio(),
                    widget.user.getWallet().getEarnings()
                  ]),
                  builder: (BuildContext context, AsyncSnapshot<List<double>> snapshot) {
                    if (snapshot.data?[0] != null && snapshot.data?[1] != null) {
                      return Earnings(wallet: widget.user.getWallet());
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
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
  Text _portfolioText = Text("");
  Text _earningText = Text("");
  double? portfolio;
  double? earnings;

  void getTexts() {
    portfolio = widget.wallet.portfolio;
    earnings = widget.wallet.earnings;

    if (earnings == null) {
      _portfolioText = Text(portfolio.toString());
      _earningText = Text(earnings.toString());
    } else if (earnings! < 0) {
      _portfolioText = generateText(portfolio.toString(), Colors.red);
      _earningText = generateText(earnings.toString(), Colors.red);
    } else if (earnings! > 0) {
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
            Text("Available Funds: "),
            Text(widget.wallet.getAvailableFunds().toString()),
          ],
        ),
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