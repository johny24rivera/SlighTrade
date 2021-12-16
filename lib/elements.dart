import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:slightrade/pages/stock.dart';
import 'package:yahoofin/yahoofin.dart';
import 'package:flutter/services.dart';

import 'objects/user.dart';

Padding generateTextField(TextEditingController controller, String label, Icon icon, [bool pass = false]) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: TextField(
                controller: controller,
                obscureText: pass,
                decoration: InputDecoration(
                  prefixIcon: icon,
                  labelText: label,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 5,
                      style: BorderStyle.solid
                    )
                  )
                ),
              )
            );
}


ElevatedButton generateButton(void Function() click, [String message = "Submit"]) {
  return ElevatedButton(
    onPressed: click,
    child: Text(message),
  );
}

Padding generateNumberField(TextEditingController controller) {
  return Padding(
    padding: EdgeInsets.all(20),
    child: new TextField(
      controller: controller,
      decoration: new InputDecoration(labelText: "Enter your number"),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter> [
        FilteringTextInputFormatter.digitsOnly
      ], // Only numbers can be entered
    ),
  );
}

Padding generateLink(void Function() click, String link) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 15),
            ),
            onPressed: click,
            child: Text(link),
          )
  );
}

void generateAlert(String title, String message, context){
  Alert(
    context: context,
    title: title,
    desc: message,
  ).show();
}

Text generateText(String text, [Color color = Colors.black, FontWeight weight = FontWeight.normal]) {
  return Text(text,
    style: TextStyle(
      color: color,
      fontWeight: weight
    )
  );
}

User getPracticeUser() {
  User user = new User.withoutWallet(
    "goldcode_yt",
    "Jonathan24rivera@gmail.com",
    "Password",
  );

  return user;
}

TextField generateSearchBar(BuildContext context, User user) {
  TextEditingController search = new TextEditingController();

  return TextField(
    controller: search,
    decoration: InputDecoration(
      prefixIcon: Icon(Icons.search),
      contentPadding: const EdgeInsets.all(20),
      isDense: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelText: "Search...",
      labelStyle: TextStyle(
        color: Color(0xff5B5B5B),
        fontSize: 17.0,
        fontWeight: FontWeight.w500,
      ),
      alignLabelWithHint: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: BorderSide(
          color: Colors.black,
          width: 5,
          style: BorderStyle.solid
        ),
      ),
    ),
    onSubmitted: (search) {
      print(search);
      final yfin = YahooFin();

      StockInfo info = yfin.getStockInfo(ticker: search);
      print("Navigate to page");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StockPage(info: info, user: user))
      );
    },
  );
}

IconButton generateMenuButton() {
  return new IconButton(
    icon: Icon(Icons.menu),
    tooltip: 'Menu',
    onPressed: () {
      
    },
  );
}

void updateUser(User user) {
  FirebaseFirestore.instance
    .collection('users')
    .doc(user.id)
    .set(user.toJson());
}

String sanitize(String input) {
  return input.toLowerCase().trim();
}