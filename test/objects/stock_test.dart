import 'package:slightrade/objects/stock.dart';
import 'package:test/test.dart';

main() {
  test('Test for check constructors and getters', () {
    String name = 'Microsoft';
    String ticker = 'msft';
    double purchasePrice = 34.87;
    int quantity = 3;
    Stock stock = new Stock.withoutCurrentPrice(name, ticker, purchasePrice, quantity);

    expect(stock.getName(), name);
    expect(stock.getValue(), purchasePrice);
    expect(stock.getPurchasePrice(), purchasePrice);
    expect(stock.getEarnings(), 0);
  });
}