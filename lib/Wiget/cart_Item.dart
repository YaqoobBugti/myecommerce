import 'package:flutter/material.dart';
import 'package:myecommerce/provider/provider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  final String image;
  final double price;
  final String title;
  final int que;
  final String color;
  final String size;
  CartItem({
    @required this.price,
    @required this.color,
    @required this.size,
    @required this.image,
    @required this.title,
    @required this.que,
  });
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  double total;
  double m;
  Widget dismissible() {
    MyProvider provider = Provider.of<MyProvider>(context);
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: Text('Confirmation'),
            content: Text('Do you want to save?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop(
                      false); 
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pop(true); 
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      },
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) {
        setState(() {
          provider.delete();
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 120,
                  width: 110,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.image),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '\$ ${widget.price}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.color,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Text(
                        '${widget.que}x',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.pink[50],
                      child: Text(
                        '${widget.size}',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(
      context,
      listen: false,
    );
    var pricepeice = provider.cartProductlist;
    pricepeice.forEach(
      (element) {
        total = element.price * widget.que;
      },
    );
    return dismissible();
  }
}
