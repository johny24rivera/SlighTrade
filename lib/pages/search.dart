import 'package:flutter/material.dart';
import 'package:slightrade/elements.dart';


class SearchPage extends StatelessWidget {
  const SearchPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[],
        leading: generateMenuButton(),
      ),
      body: SearchWidget(),
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({ Key? key }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
Widget build(BuildContext context) {
  return Scaffold (
    // This is handled by the search bar itself.
    resizeToAvoidBottomInset: false,
    body: Stack(
      fit: StackFit.expand,
      children: [],
    ),
  );
  }


}