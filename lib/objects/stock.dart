class Stock {
  late String _name;
  late double _currentPrice;
  late double _purchasePrice;
  late int _quantity;

  Stock(this._name, this._currentPrice, this._purchasePrice, this._quantity);
  Stock.withoutQuantity(this._name, this._currentPrice, this._purchasePrice);

  double getValue() {
    update();
    return _currentPrice;
  }

  double getEarnings() {
    update();
    return _quantity * (_currentPrice - _purchasePrice);
  }

  void update() {
    // update current price;
  }
}