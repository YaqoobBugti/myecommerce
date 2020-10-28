import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myecommerce/model/category.dart';
import 'package:myecommerce/model/product.dart';

class MyCategory with ChangeNotifier {
  List<Categories> _childProduct = [];
  Categories child;
  Future<void> allgetChildProduct() async {
    List<Categories> newchildProduct = [];
    QuerySnapshot allChildProduct = await FirebaseFirestore.instance
        .collection('category')
        .doc('zlnS6VqwZytVWfwhJk7X')
        .collection('child')
        .get();
    allChildProduct.docs.forEach(
      (element) {
        child = Categories(
            tittle: element.data()['tittle'], image: element.data()['image']);
        newchildProduct.add(child);
      },
    );
    _childProduct = newchildProduct;

  }

  get getallChildProduct {
    return _childProduct;
  }

////////////man product  fuction
  List<Categories> _manProduct = [];
  Categories man;
  Future<void> allgetManProduct() async {
    List<Categories> newManProduct = [];
    QuerySnapshot allManProduct = await FirebaseFirestore.instance
        .collection('category')
        .doc('zlnS6VqwZytVWfwhJk7X')
        .collection('man')
        .get();
    allManProduct.docs.forEach(
      (element) {
        man = Categories(
          tittle: element.data()['tittle'],
          image: element.data()['image'],
        );
        newManProduct.add(man);
      },
    );
    _manProduct = newManProduct;

  }

  get getallManProduct {
    return _manProduct;
  }

  ////////////womanProduct//////////
  List<Categories> _womanProduct = [];
  Categories woman;
  Future<void> allgetWomanProduct() async {
    List<Categories> newWomanProduct = [];
    QuerySnapshot allWomanProduct = await FirebaseFirestore.instance
        .collection('category')
        .doc('zlnS6VqwZytVWfwhJk7X')
        .collection('woman')
        .get();
    allWomanProduct.docs.forEach(
      (element) {
        woman = Categories(
            tittle: element.data()['tittle'], image: element.data()['image']);
        newWomanProduct.add(woman);
      },
    );
    _womanProduct = newWomanProduct;
  }

  get getallWomanProduct {
    return _womanProduct;
  }

  //////////// childrens all categorys////////////
  List<Product> _childCategories = [];
  Product childCategories;
  Future<void> allgetChildCategories() async {
    List<Product> newchildCategories = [];
    QuerySnapshot allChildCategories = await FirebaseFirestore.instance
        .collection('categorieslist')
        .doc('q6nYXmNFi7CkNbSiSZTS')
        .collection('child')
        .get();
    allChildCategories.docs.forEach(
      (element) {
        childCategories = Product(
          price: element.data()['price'],
          tittle: element.data()['tittle'],
          image: element.data()['image'],
        );
        newchildCategories.add(childCategories);
      },
    );
    _childCategories = newchildCategories;
  }

  get getallChildCategories {
    return _childCategories;
  }

  ///////////////////all man Categories //////////////////////

  List<Product> _manCategories = [];
  Product manCategories;
  Future<void> allgetManCategories() async {
    List<Product> newmanCategories = [];
    QuerySnapshot allmanCategories = await FirebaseFirestore.instance
        .collection('categorieslist')
        .doc('q6nYXmNFi7CkNbSiSZTS')
        .collection('man')
        .get();
    allmanCategories.docs.forEach(
      (element) {
        manCategories = Product(
          price: element.data()['price'],
          tittle: element.data()['tittle'],
          image: element.data()['image'],
        );
        newmanCategories.add(manCategories);
      },
    );
    _manCategories = newmanCategories;
    notifyListeners();
  }

  get getallManCategories {
    return _manCategories;
  }

//////////////////////womanall Categories///////////////

  List<Product> _womanCategories = [];
  Product womanCategories;
  Future<void> allgetWomanCategories() async {
    List<Product> newwomanCategories = [];
    QuerySnapshot allwomanCategories = await FirebaseFirestore.instance
        .collection('categorieslist')
        .doc('q6nYXmNFi7CkNbSiSZTS')
        .collection('woman')
        .get();
    allwomanCategories.docs.forEach(
      (element) {
        womanCategories = Product(
          price: element.data()['price'],
          tittle: element.data()['tittle'],
          image: element.data()['image'],
        );
        newwomanCategories.add(womanCategories);
      },
    );
    _womanCategories = newwomanCategories;
  }

  get getallWomanCategories {
    return _womanCategories;
  }

///////////////////////   Search   ////////////////////////

  List<Product> searchList;
  void getSearchList({List<Product> list}) {
    searchList = list;
  }

  List<Product> searchCategoryList(String query) {
    List<Product> searchShirt = searchList.where(
      (element) {
        return element.tittle.toUpperCase().contains(query) ||
            element.tittle.toLowerCase().contains(query) ||
            element.tittle.toUpperCase().contains(query) &&
                element.tittle.toLowerCase().contains(query);
      },
    ).toList();
    return searchShirt;
  }
//////////////////////////  End Search  /////////////////////

}
