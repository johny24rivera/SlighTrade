import 'package:slightrade/objects/funds.dart';
import 'package:slightrade/objects/stock.dart';
import 'package:slightrade/objects/stocks.dart';

class Wallet extends Object {
  late double portfolio;
  late Funds funds;
  late Stocks stocks;
  late double earnings;

  Wallet(this.funds, this.stocks);

  Wallet.withWallet(Wallet wallet) {
    this.portfolio = wallet.portfolio;
    this.funds = wallet.funds;
    this.stocks = wallet.stocks;
    this.earnings = wallet.earnings;
  }

  Wallet.empty() {
    this.funds = new Funds.empty();
    this.stocks = new Stocks();
    this.portfolio = 0;
    this.earnings = 0;
  }

  void setFunds(Funds fund) => {this.funds = fund};

  double getAvailableFunds() {
    return funds.getFunds();
  }

  bool ownStock(ticker) {
    return stocks.ownStock(ticker);
  }

  Future<double> getEarnings() async {
    this.earnings = await stocks.getEarnings();
    return earnings;
  }

  Future<double> getPortfolio() async {
    double fundPort = funds.getFunds();
    double stockPort = await stocks.getValue();
    portfolio = stockPort + fundPort;

    return portfolio;
  }

  void buyStock(Stock stock){
    funds.buyStocks(stock);
    stocks.buy(stock);
  }

  void sellStock(Stock stock) {
    double sellPrice = stock.quantity * stock.currentPrice;
    funds.sellStocks(sellPrice);
    stocks.sell(stock);
  }

  List<Stock> getStocks() {
    return stocks.getOwnedStocks();
  }

  List<Stock> getFollowedStocks() {
    return stocks.getFollowedStocks();
  }

  update() async {
    stocks.update();
    portfolio = this.funds.getFunds() + await this.stocks.getValue();
  }

  Map<String,dynamic> toJson() => {
    'portfolio' : portfolio,
    'funds' : funds.toJson(),
    'stocks' : stocks.toJson(),
    'earnings' : earnings,
  };
}