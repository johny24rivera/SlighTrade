import 'dart:convert';

class User extends Object {
  late String _username;
  late String _email;
  late String _password;

  User(String user, String email, String password) {
    this._username = user;
    this._email = email;
    this._password =  password;
  }

  Map<String,dynamic> toJson() => {
    'username': _username,
    'email' : _email,
    'password' : _password,
  };
}