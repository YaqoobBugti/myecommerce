import 'package:flutter/material.dart';

class BottomPart extends StatelessWidget {
  final String tittle;
  final String image;
  final double price;
  final Function onTap;
  BottomPart({this.tittle, this.image, this.price, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                height: 200,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(image),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0.3,
                      offset: Offset(0, 1),
                      color: Colors.grey,
                    ),
                  ],
                  color: Color(0xfff2f2f2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100.withOpacity(0.9),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(10)),
                ),
                child: Center(child: Text('\$ $price')),
              )
            ],
          ),
        ),
        Text(
          tittle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
