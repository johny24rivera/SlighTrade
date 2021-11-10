import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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


ElevatedButton generateButton(void Function() click) {
  return ElevatedButton(
    onPressed: click,
    child: Text("Submit"),
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

IconButton generateSearchIcon() {
  return new IconButton(
    icon: Icon(Icons.search),
    tooltip: 'Search',
    onPressed: () {

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