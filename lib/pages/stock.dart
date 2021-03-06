import 'package:flutter/material.dart';
import 'package:slightrade/elements.dart';
import 'package:slightrade/objects/stock.dart';
import 'package:slightrade/objects/user.dart';
import 'package:slightrade/pages/homePage.dart';
import 'package:yahoofin/yahoofin.dart';

class StockPage extends StatefulWidget {
  const StockPage({ Key? key, required this.info, required this.user }) : super(key: key);

  final StockInfo info;
  final User user;
  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  YahooFin yfin = YahooFin();
  late double? stockPrice;
  late String ticker = widget.info.ticker!;

  @override
  Widget build(BuildContext context) {
    print(ticker);
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(ticker),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: FutureBuilder(
                future: Future.value(yfin.getPrice(stockInfo: widget.info)).catchError((onError) => print(onError.toString())),
                builder: (BuildContext context, AsyncSnapshot<StockQuote> snapshot) {
                  print("check stuff");
                  print(snapshot.toString());
                  if (snapshot.data != null) {
                    stockPrice = snapshot.data!.currentPrice;
                    return (stockPrice != null) ? StockPriceView(
                      price: snapshot.data!, 
                      user: widget.user,
                      ticker: ticker) : 
                      Text("Stock not found");
                  } else {
                    return Center(child: CircularProgressIndicator(),);
                  }
                }
              ),
            ),
          ]
        )
      ),
    );
  }
}

class StockPriceView extends StatefulWidget {
  const StockPriceView({ Key? key, required this.price,
    required this.user,
    required this.ticker}) : super(key: key);

  final StockQuote price;
  final User user;
  final String ticker;
  @override
  _StockPriceViewState createState() => _StockPriceViewState();
}

class _StockPriceViewState extends State<StockPriceView> {
  TextEditingController controller = new TextEditingController();
  late double? stockPrice = widget.price.currentPrice;
  void buyStock() {

    int quantity = int.parse(controller.text);
    double price = stockPrice! * quantity;
    double funds = widget.user.getWallet().getAvailableFunds();

    if (price > funds) {
      print("Generate Alert");
      generateAlert("Invalid Amount", "You do not have enough funds to buy this stock", context);
    } else {
      print("Buy Stock");
      Stock stock = new Stock.withoutCurrentPrice(widget.ticker, widget.ticker, stockPrice!, quantity);
      widget.user.buyStock(stock);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user: widget.user)
          // builder: (context) => HomePage()
        )
      );
    }
  }

  void sellStock() {
    int quantity = int.parse(controller.text);

    Stock stock = new Stock.withoutCurrentPrice(widget.ticker, widget.ticker, stockPrice!, quantity);
    widget.user.sellStock(stock);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(user: widget.user)
          // builder: (context) => HomePage()
        )
      );
  }

  void follow() {
    Stock followed = new Stock.follow(widget.ticker, widget.ticker);
    widget.user.follow(followed);
  }

  void unfollow() {
    widget.user.unfollow(widget.ticker);
  }

  void onPressed() {
    setState(() {
      if (widget.user.followStock(widget.ticker)) {
        unfollow();
      } else {
        follow();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    IconButton follow = new IconButton(
      onPressed: onPressed,
      icon: widget.user.followStock(widget.ticker) 
        ? Icon(Icons.favorite) : Icon(Icons.favorite_border)
    );

    if (widget.user.ownStock(widget.ticker) == false) {
      return Column(
        children: <Widget>[
          follow,
          Text(widget.price.currentPrice.toString()),
          generateNumberField(controller),
          generateButton(buyStock, "Buy Stock"),
        ]
      );
    }

    return Column(
        children: <Widget>[
          follow,
          Text(widget.price.currentPrice.toString()),
          generateNumberField(controller),
          generateButton(buyStock, "Buy Stock"),
          generateButton(sellStock, "Sell Stock"),
        ]
      );
  }


}