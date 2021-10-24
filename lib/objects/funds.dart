class Funds {
  late double _initialFunds;
  late double _availableFunds;

  Funds(this._initialFunds, this._availableFunds);

  Funds.withFunds(Funds fund) {
    this._initialFunds = fund._initialFunds;
    this._availableFunds = fund._availableFunds;
  }

  Funds.empty() {
    this._availableFunds = 0;
    this._initialFunds = 0;
  }

  void setInitialFunds(double funds) {
    this._initialFunds = funds;
    this._availableFunds = _initialFunds;
  }

  void addFund(double funds) {
    this._initialFunds += funds;
    this._availableFunds += funds;
  }

  double getFunds() {
    return _availableFunds;
  }

  Map<String,dynamic> toJson() => {
    '_initialFunds' :  _initialFunds,
    '_availableFunds' : _availableFunds
  };
}