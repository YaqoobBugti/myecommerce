import 'package:flutter/material.dart';
import 'package:myecommerce/Wiget/button.dart';
import 'package:myecommerce/Wiget/cart_Item.dart';
import 'package:myecommerce/provider/provider.dart';

import 'package:myecommerce/screen/home_screen.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget {
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  double total = 0.0;
  double texs = 3;
  double discountRupees;
  double shipping = 10;
  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    discountRupees = shipping / 100 * texs;
    total = provider.totalAmount() + shipping - discountRupees;
    if (provider.cartProductlist.isEmpty) {
      total = 0.0;
      texs = 0.0;
      discountRupees = 0.0;
      shipping = 0.0;
    }
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
        centerTitle: true,
        title: Text("CheckOut"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                  itemCount: provider.cartProductLength,
                  itemBuilder: (context, index) {
                    provider.getDeleteIndex(index);
                    return CartItem(
                      que: provider.cartProductlist[index].que,
                      price: provider.cartProductlist[index].price,
                      image: provider.cartProductlist[index].image,
                      title: provider.cartProductlist[index].tittle,
                      color: provider.cartProductlist[index].color,
                      size: provider.cartProductlist[index].size,
                    );
                  }),
            ),
            Container(
              height: 300,
              width: double.infinity,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ListTile(
                    leading: Text('Subtotal',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        )),
                    trailing: Text(
                      '\$ ${provider.totalAmount()}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'Shipping Cost',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '\$ $shipping',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'Texs',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '\$ $discountRupees',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '\$ $total',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Builder(
              builder: (ctx) {
                return Button(
                  buttoncolors: Theme.of(context).textSelectionColor,
                  textcolor: Colors.white,
                  tittle: 'Check Out',
                  whenpress: provider.totalAmount() <= 0
                      ? null
                      : () async {
                          await Provider.of<MyProvider>(context, listen: false)
                              .addOder(
                            provider.cartProductlist.toList(),
                            provider.totalAmount(),
                          );
                          provider.clean();
                          Scaffold.of(ctx).showSnackBar(
                            SnackBar(
                              content: Text('Send Your Orders'),
                              backgroundColor: Theme.of(context).accentColor,
                            ),
                          );
                        },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
