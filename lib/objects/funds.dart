import 'package:slightrade/objects/stock.dart';

class Funds {
  late double _initialFunds;
  late double _availableFunds;

  Funds(this._initialFunds, this._availableFunds);

  Funds.withFunds(Funds fund) {
    this._initialFunds = fund._initialFunds;
    this._availableFunds = fund._availableFunds;
  }

  Funds.withInitial(double initial) {
    assert(initial > 0);
    this._initialFunds = initial;
    this._availableFunds = initial;
  }

  Funds.empty() {
    this._availableFunds = 0;
    this._initialFunds = 0;
  }

  void setInitialFunds(double funds) {
    assert(funds > 0);
    this._initialFunds = funds;
    this._availableFunds = _initialFunds;
  }

  void addFund(double funds) {
    assert(funds > 0);
    this._initialFunds += funds;
    this._availableFunds += funds;
  }

  void buyStocks(Stock stock) {
    double purchasePrice = stock.getPurchasePrice() * stock.quantity;
    assert(purchasePrice > 0);
    if (purchasePrice <= _availableFunds) {
      this._availableFunds -= purchasePrice;
    } else {
      throw Exception("There are not enough funds");
    }
  }

  void sellStocks(double sellPrice) {
    assert(sellPrice > 0);
    this._availableFunds += sellPrice;
  }

  double getFunds() {
    return _availableFunds;
  }

  double getInitialFunds() {
    return _initialFunds;
  }

  Map<String,dynamic> toJson() => {
    '_initialFunds' :  _initialFunds,
    '_availableFunds' : _availableFunds
  };

  Funds.fromJson(Map<String, dynamic> json) {
    this._initialFunds = json["_initialFunds"];
    this._availableFunds = json["_availableFunds"];
  }
}