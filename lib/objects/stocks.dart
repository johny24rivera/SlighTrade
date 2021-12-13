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

  bool ownStock(ticker) {
    for (Stock stock in this._ownedStocks) {
      if (stock.ticker == ticker) {
        return true;
      }
    }
    return false;
  }

  void buy(Stock stock) {
    _ownedStocks.add(stock);
  }

  void sell(Stock stock) async {
    var stockIndeces = <int>[];
    for (int i = 0; i < this._ownedStocks.length; i++) {
      if (this._ownedStocks[i].ticker == stock.ticker) {
        stockIndeces.add(i);
      }
    }

    int i = stockIndeces.length - 1;
    while (stock.quantity != 0) {
      int index = stockIndeces[i];
      int inputQuantity = stock.quantity;
      int ownedQuantity = this._ownedStocks[index].quantity;

      if (inputQuantity > ownedQuantity) {
        stock.setQuantity(inputQuantity - ownedQuantity);
        this._ownedStocks.removeAt(index);
        i -= 1;
      } else if (inputQuantity < ownedQuantity) {
        this._ownedStocks[index].setQuantity(ownedQuantity - inputQuantity);
        return;
      } else {
        this._ownedStocks.removeAt(index);
        return;
      }
    }
  }

  void follow(Stock stock) {
    _followedStocks.add(stock);
  }

  void unfollow(Stock stock) {
    _followedStocks.remove(stock);
  }

  Future<double> getValue() async {
    double value = 0;
    for (int i = 0; i < _ownedStocks.length; i++)  {
      double price = await _ownedStocks[i].getValue();
      value += price;
    }

    return value;
  }

  Future<double> getEarnings() async {
    double value = 0;
    for (int i = 0; i < _ownedStocks.length; i++) {
      double price = await _ownedStocks[i].getEarnings();
      value += price;
    }

    return value;
  }

  void update() async {
    for (int i = 0; i < _ownedStocks.length; i++) {
      await _ownedStocks[i].update();
    }

    for (int i = 0; i < _followedStocks.length; i++) {
      await _followedStocks[i].update();
    }
  }

  List<Stock> getOwnedStocks() {
    return _ownedStocks;
  }

  List<Stock> getFollowedStocks() {
    return _followedStocks;
  }
}