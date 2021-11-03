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

  String getName() {
    return _name;
  }

  double getPurchasePrice() {
    return _purchasePrice;
  }

  double getValue() {
    update();
    return _currentPrice;
  }

  double getEarnings() {
    update();
    return _quantity * (_currentPrice - _purchasePrice);
  }

  void update() {
    final yfin = YahooFin();
    late StockQuote price;
    StockInfo info = yfin.getStockInfo(ticker: _ticker);
    yfin.getPrice(stockInfo: info)
      .then((value) => price = value);
    print(price.toString());
  }
}