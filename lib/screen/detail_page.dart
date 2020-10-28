import 'package:flutter/material.dart';
import 'package:myecommerce/provider/provider.dart';
import 'package:myecommerce/screen/check_out.dart';
import 'package:myecommerce/screen/home_screen.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String image;
  final String tittle;
  final double price;
  DetailPage(
      {@required this.image, @required this.price, @required this.tittle});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int count = 1;
  double totalPrice;
  List<bool> _size = List.generate(3, (_) => false);
  List<bool> _color = List.generate(3, (_) => false);

  int colorIndex = 0;
  String color;
  void getColor() {
    if (colorIndex == 0) {
      setState(() {
        color = "Yellow";
      });
    } else if (colorIndex == 1) {
      setState(() {
        color = "blue";
      });
    } else if (colorIndex == 2) {
      setState(() {
        color = "red";
      });
    }
  }

  int sizeIndex = 0;
  String size;
  void getSize() {
    if (sizeIndex == 0) {
      setState(() {
        size = "9";
      });
    } else if (sizeIndex == 1) {
      setState(() {
        size = "8";
      });
    } else if (sizeIndex == 2) {
      setState(() {
        size = "10";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (totalPrice == null) {
      totalPrice = widget.price;
    }
    MyProvider myProvider = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff2f2f2),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.image),
                ),
                color: Color(0xfff2f2f2),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1.3,
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(2, 9),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    count++;
                                    totalPrice = count * widget.price;
                                  },
                                );
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.black38,
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Text(
                              count.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    if (count > 1) {
                                      count--;
                                      totalPrice = count * widget.price;
                                    }
                                  },
                                );
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.black38,
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "\$$totalPrice",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
          
                  Text(
                      widget.tittle,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  Text(
                      "COLORS",
                      style: TextStyle(fontSize: 20),
                    ),
          
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ToggleButtons(
                        borderColor: Colors.grey,
                        disabledColor: Colors.grey,
                        highlightColor: Colors.pink,
                        fillColor: Colors.black12,
                        renderBorder: false,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.yellow[300],
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.blue,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.red,
                          ),
                        ],
                        isSelected: _color,
                        onPressed: (index) {
                          setState(() {
                            for (var i = 0; i < _color.length; i++) {
                              if (i == index) {
                                _color[i] = true;
                              } else {
                                _color[i] = false;
                              }
                            }
                          });
                          setState(() {
                            colorIndex = index;
                          });
                        },
                      ),
                
                    ],
                  ),
                   Text(
                      "SIZES",
                      style: TextStyle(fontSize: 20),
                    ),
             
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ToggleButtons(
                        borderColor: Colors.grey,
                        disabledColor: Colors.grey,
                        highlightColor: Colors.pink,
                        fillColor: Colors.black12,
                        renderBorder: false,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Text("8"),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Text("9"),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Text("10"),
                          ),
                        ],
                        isSelected: _size,
                        onPressed: (index) {
                          setState(
                            () {
                              for (var i = 0; i < _size.length; i++) {
                                if (i == index) {
                                  _size[i] = true;
                                } else {
                                  _size[i] = false;
                                }
                              }
                            },
                          );
                          setState(() {
                            sizeIndex = index;
                          });
                        },
                      ),
                    ],
                  ),
                  Container(
                   // margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 55,
                    width: double.infinity,
                    child: RaisedButton(
                      color: Theme.of(context).textSelectionColor,
                      elevation: 1.5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        getColor();
                        getSize();
                        myProvider.addNotification('Item');
                        myProvider.addCartProduct(
                          image: widget.image,
                          price: widget.price,
                          tittle: widget.tittle,
                          que: count,
                          color: color,
                          size: size,
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CheckOut(),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'Add to cart',
                          style: TextStyle(fontSize: 25, color: Colors.black),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
