import 'package:slightrade/objects/stock.dart';

class Stocks {
  List<Stock> _ownedStocks = [];
  List<Stock> _followedStocks = [];

  Stocks();

  Stocks.withOtherStock(Stocks stocks) {
    this._ownedStocks = stocks._ownedStocks;
    this._followedStocks = stocks._followedStocks;
  }

  Map<String,dynamic> toJson() => {
    '_ownedStocks' : _ownedStocks,
    '_followedStocks' : _followedStocks,
  };

  double getValue() {
    double value = 0;
    for (int i = 0; i < _ownedStocks.length; i++) {
      value += _ownedStocks[i].getValue();
    }

    return value;
  }

  double getEarnings() {
    double value = 0;
    for (int i = 0; i < _ownedStocks.length; i++) {
      value += _ownedStocks[i].getEarnings();
    }

    return value;
  }

  void update() {
    for (int i = 0; i < _ownedStocks.length; i++) {
      _ownedStocks[i].update();
    }

    for (int i = 0; i < _followedStocks.length; i++) {
      _followedStocks[i].update();
    }
  }
}