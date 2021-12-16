import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:slightrade/objects/stock.dart';
import 'package:slightrade/objects/wallet.dart';

class User extends Object {
  late String _username;
  late String _email;
  late String _password;
  late Wallet _wallet;
  String _id = '';

  User(this._username, this._email, this._password, this._wallet);
  User.withoutWallet(this._username, this._email, this._password) {
    _wallet = new Wallet.empty();
  }

  User.empty() {
    this._wallet = new Wallet.empty();
    this._username = '';
    this._email = '';
    this._password = '';
  }

  get id => _id;
  void setId(String id) {
    this._id = id;
  }

  Future<void> updateAllStocks() async {
    await _wallet.update();
  }

  bool ownStock(ticker) {
    return _wallet.ownStock(ticker);
  }

  bool followStock(ticker) {
    return _wallet.followStock(ticker);
  }

  void follow(Stock stock) {
    _wallet.follow(stock);
  }

  void unfollow(ticker) {
    _wallet.unfollow(ticker);
  }

  Wallet getWallet() {return _wallet;}

  void buyStock(Stock stock) {
    _wallet.buyStock(stock);
    FirebaseFirestore.instance
    .collection('users')
    .doc(_id)
    .set(toJson())
    .then((value) => print("updated user"));
  }

  void sellStock(Stock stock) {
    _wallet.sellStock(stock);

  }

  Map<String,dynamic> toJson() => {
    '_username': _username,
    '_email' : _email,
    '_password' : _password,
    '_wallet' : _wallet.toJson(),
    '_id' : _id
  };

  User.fromJson(Map<String, dynamic> json) {
    this._username = json["_username"];
    this._email = json["_email"];
    this._password = json["_password"];
    this._wallet = new Wallet.fromJson(json["_wallet"]);
    this._id = json["_id"];
  }
}