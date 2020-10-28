import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myecommerce/model/cartproduct.dart';
import 'package:myecommerce/model/oder.dart';
import 'package:myecommerce/model/product.dart';
import 'package:myecommerce/model/user.dart';

class MyProvider with ChangeNotifier {
  List<Product> _womanlist = [];
  Product addproduct;
  Product woman;
  Future<void> allgetProduct() async {
    List<Product> newListWoman = [];
    QuerySnapshot allProduct =
        await FirebaseFirestore.instance.collection('product').get();
    allProduct.docs.forEach(
      (element) {
        woman = Product(
          price: element.data()['price'],
          tittle: element.data()['tittle'],
          image: element.data()['image'],
        );
        newListWoman.add(woman);
      },
    );

    _womanlist = newListWoman;
  }

  get getallproduct {
    return _womanlist;
  }

  ////
  List<Product> _seeAllProduct = [];
  Product seeAllProduct;
  Future<void> getSeeAllProduct() async {
    List<Product> newseeAllProduct = [];
    QuerySnapshot seenAllProduct =
        await FirebaseFirestore.instance.collection('product').get();
    seenAllProduct.docs.forEach(
      (element) {
        seeAllProduct = Product(
          price: element.data()['price'],
          tittle: element.data()['tittle'],
          image: element.data()['image'],
        );
        newseeAllProduct.add(seeAllProduct);
      },
    );
    _seeAllProduct = newseeAllProduct;
  }

  notifyListeners();
  get getSeenAllProduct {
    return _seeAllProduct;
  }

  ////////////////////
  ///
  ///
  List<CartProduct> cartProductlist = [];
  CartProduct cartProduct;
  void addCartProduct({
    final String tittle,
    final String image,
    final double price,
    final String color,
    final String size,
    final int que,
  }) {
    cartProduct = CartProduct(
        que: que,
        image: image,
        price: price,
        tittle: tittle,
        color: color,
        size: size);
    cartProductlist.add(cartProduct);
    notifyListeners();
  }

  List<CartProduct> get getCartProduct {
    return List.from(cartProductlist);
  }

  int get cartProductLength {
    return cartProductlist.length;
  }

  double totalAmount() {
    double total = 0.0;
    cartProductlist.forEach((element) {
      total += element.price * element.que;
    });
    return total;
  }

  int myDeleteIndex;
  void getDeleteIndex(int index) {
    myDeleteIndex = index;
  }

  void delete() {
    cartProductlist.removeAt(myDeleteIndex);
    notifyListeners();
  }
  void clean() {
    cartProductlist.clear();
    notifyListeners();
  }
  ////////////////////////  Search Barr    //////////////////////////

  List<Product> search(String query) {
    List<Product> searchList = _seeAllProduct.where((element) {
      return element.tittle.toUpperCase().contains(query) ||
          element.tittle.toLowerCase().contains(query) ||
          element.tittle.toUpperCase().contains(query) &&
              element.tittle.toLowerCase().contains(query);
    }).toList();
    return searchList;
  }
  /////////////////////////////////Search End //////////////////////////////////

//////////////// User /////////////////////////////////////

  UserData _users;
  User currentUser = FirebaseAuth.instance.currentUser;

  Future fetchUserData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('user').get();
    snapshot.docs.forEach(
      (checkDocument) {
        if (currentUser.uid == checkDocument.data()["userid"]) {
          _users = UserData(
            email: checkDocument.data()['Email'],
            fullname: checkDocument.data()["FullName"],
            password: checkDocument.data()["password"],
            image: checkDocument.data()["imageUrl"],
            phone: checkDocument.data()["PhoneNumber"],

          );
        }
      },
    );
    notifyListeners();
  }

  get getCurrrentUser {
    return _users == null
        ? UserData(email: '', fullname: '', password: '', image: '', phone: '')
        : _users;
  }

/////////////////////Oder///////////////////////

  List<Oder> _order = [];
  List<Oder> get oders {
    return [..._order];
  }

  UserData userData;

  Future<void> addOder(List<CartProduct> cartProduct, double total) async {
    final timestamp = DateTime.now();
    try {
      FirebaseFirestore.instance.collection('userOder').add({
        'OrderName': _users.fullname,
        'OrderEmail': _users.email,
        'OrderImage': _users.image,
        'OderPhoneNumber':_users.phone,
        'OrderId': DateTime.now().toString(),
        'OrderAmount': total,
        'OderTimeDate': timestamp.toIso8601String(),
        'oderProduct': cartProduct
            .map((e) => {
                  'OrderImage': e.image,
                  'OrderColor': e.color,
                  'OrderTittle': e.tittle,
                  'OrderSize': e.size,
                  'OrderQueantity': e.que,
                  'OrderPrice': e.price
                })
            .toList()
      });
      _order.insert(
        0,
        Oder(
          amount: total,
          product: cartProduct,
          id: DateTime.now().toString(),
          time: timestamp,
        ),
      );
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
  ////////////////// Notifications ////////////////////
  List<String> notifireList = [];

  void addNotification(String notification) {
    notifireList.add(notification);
  }

  int get getNotificationIndex {
    return notifireList.length;
  }

  get getNotificationList {
    return notifireList;
  }
}
