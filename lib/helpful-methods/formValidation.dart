import 'package:crypto/crypto.dart';
import 'dart:convert';


/// Input: String password
/// Output: String hashedPassword
/// return a hashed version of the text imported.
String hashPassword(String password) {
  return md5.convert(utf8.encode(password)).toString();
}
