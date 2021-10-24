import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:slightrade/objects/funds.dart';
import 'package:slightrade/objects/stocks.dart';

class Wallet extends Object {
  late double portfolio;
  late Funds funds;
  late Stocks stocks;

  Wallet(this.funds, this.stocks);

  Wallet.withWallet(Wallet wallet) {
    this.portfolio = wallet.portfolio;
    this.funds = wallet.funds;
    this.stocks = wallet.stocks;
  }

  Wallet.empty() {
    this.funds = new Funds.empty();
    this.stocks = new Stocks();
  }

  update() {
    stocks.update();
    portfolio = this.funds.getFunds() + this.stocks.getValue();
  }

  Map<String,dynamic> toJson() => {
    'portfolio' : portfolio,
    'funds' : funds.toJson(),
    'stocks' : stocks.toJson()
  };
}