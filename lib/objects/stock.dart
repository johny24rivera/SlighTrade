import 'package:yahoofin/yahoofin.dart';

class Stock {
  late String _name;
  late String _ticker;
  late double _currentPrice;
  late double _purchasePrice;
  late int _quantity;
  bool _changed = false;

  Stock(this._name, this._ticker, this._currentPrice, this._purchasePrice, this._quantity);
  Stock.withoutQuantity(this._name, this._ticker, this._currentPrice, this._purchasePrice);
  Stock.withoutCurrentPrice(this._name, this._ticker, this._purchasePrice, this._quantity) {
    this._currentPrice = this._purchasePrice;
  }
  
  get changed => _changed;

  String getName() {
    return _name;
  }

  double getPurchasePrice() {
    return _purchasePrice;
  }

  Future<double> getValue() async {
    await update();
    return _currentPrice;
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
        _changed = true;
      });
  }
}