import 'package:slightrade/objects/funds.dart';
import 'package:test/test.dart';

main() {
  // Tests for Constructors
  test('create an empty funds object', (){
    Funds fund = Funds.empty();
    expect(fund.getInitialFunds(), 0);
    expect(fund.getFunds(), 0);
  });

  test('create a regular funds object', () {
    double initial = 12000;
    double available = 13000;
    Funds fund = Funds(initial, available);

    expect(fund.getInitialFunds(), initial);
    expect(fund.getFunds(), available);
  });

  test('create a funds object with just initial', (){
    double funds = 13000;
    Funds fund = Funds.withInitial(funds);

    expect(fund.getInitialFunds(), funds);
    expect(fund.getFunds(), funds);
  });

  test('create fund from another fund', () {
    Funds fund1 = Funds(12000, 13000);
    Funds fund2 = Funds.withFunds(fund1);

    expect(fund2.getFunds(), fund1.getFunds());
    expect(fund1.getInitialFunds(), fund2.getInitialFunds());
  });

  // Important method tests
  test('Test addFunds() method', () {
    double initial = 1200;
    double addition = 1300;
    double total = initial + addition;
    Funds fund = Funds.withInitial(initial);
    fund.addFund(addition);

    expect(fund.getFunds(), total);
    expect(fund.getInitialFunds(), total);
  });

  test('test buyStocks()', () {
    double initial = 12000;
    double purchase = 1300;
    double available = initial - purchase;
    Funds fund = Funds.withInitial(initial);
    fund.buyStocks(purchase);

    expect(fund.getInitialFunds(), initial);
    expect(fund.getFunds(), available);
  });

  test('overbuy in buyStocks', () {
    double initial = 300;
    double purchase = 400;
    Funds fund = Funds.withInitial(initial);
    expect(() => fund.buyStocks(purchase), throwsException);
    expect(fund.getFunds(), initial);
    expect(fund.getInitialFunds(), initial);
  });

  test('test sell Stocks', () {
    double initial = 400;
    double buy = 300;
    double sell = 350;
    double available = 400 - buy + sell;
    Funds fund = new Funds.withInitial(initial);
    fund.buyStocks(buy);
    fund.sellStocks(sell);

    expect(fund.getFunds(), available);
    expect(fund.getInitialFunds(), initial);
  });
}