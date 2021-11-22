import 'package:flutter/material.dart';
import 'package:slightrade/elements.dart';
import 'package:yahoofin/yahoofin.dart';

class StockPage extends StatefulWidget {
  const StockPage({ Key? key, required this.info }) : super(key: key);

  final StockInfo info;
  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stock"),
      ),
      body: Center(
        child: Column(
          children: [],
        )
      ),
    );
  }
}