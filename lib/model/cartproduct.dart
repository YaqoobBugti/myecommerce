import 'package:flutter/cupertino.dart';

class CartProduct {
  final String tittle;
  final String image;
  final double price;
  final int que;
  final String color;
  final String size;

  CartProduct({@required this.size,@required this.color, @required this.que, @required this.tittle, @required this.image, @required this.price});
}