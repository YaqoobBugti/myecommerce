
import 'package:myecommerce/model/cartproduct.dart';

class Oder{
  final String id;
  final double amount;
  final List<CartProduct>product;
  final DateTime time;
  Oder({this.id,this.amount,this.product,this.time,});
}