import 'package:yahoofin/yahoofin.dart';

class Stock {
  late String _name;
  late String _ticker;
  late double _currentPrice;
  late double _purchasePrice;
  late int _quantity;

  Stock(this._name, this._ticker, this._currentPrice, this._purchasePrice, this._quantity);
  Stock.withoutQuantity(this._name, this._ticker, this._currentPrice, this._purchasePrice);
  Stock.withoutCurrentPrice(this._name, this._ticker, this._purchasePrice, this._quantity) {
    this._currentPrice = this._purchasePrice;
  }
  
  get quantity => _quantity;
  get currentPrice => _currentPrice;

  get ticker => _ticker;

  String getName() {
    return _name;
  }

  void setQuantity(int quantity) {
    this._quantity = quantity;
  }

  double getPurchasePrice() {
    return _purchasePrice;
  }

  Future<double> getValue() async {
    await update();
    return _currentPrice * _quantity;
  }

  Future<double> getEarnings() async {
    await update();
    return _quantity * (_currentPrice - _purchasePrice);
  }

  Future update() async {
    final yfin = YahooFin();
    StockInfo info = yfin.getStockInfo(ticker: _ticker);
    yfin.getPrice(stockInfo: info)
      .then((value) {
        _currentPrice = value.currentPrice!;
      });
  }

  Map<String,dynamic> toJson() => {
    '_name' : _name,
    '_ticker' : _ticker,
    '_currentPrice': _currentPrice,
    '_purchasePrice' : _purchasePrice,
    '_quantity' : _quantity,
  };
}

