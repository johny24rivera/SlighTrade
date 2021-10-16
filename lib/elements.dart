import 'package:flutter/material.dart';

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