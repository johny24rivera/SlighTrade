import 'package:slightrade/objects/wallet.dart';

class User extends Object {
  late String _username;
  late String _email;
  late String _password;
  late Wallet _wallet;

  User(this._username, this._email, this._password, this._wallet);
  User.withoutWallet(this._username, this._email, this._password) {
    _wallet = new Wallet.empty();
  }

  Map<String,dynamic> toJson() => {
    '_username': _username,
    '_email' : _email,
    '_password' : _password,
    '_wallet' : _wallet.toJson()
  };
}