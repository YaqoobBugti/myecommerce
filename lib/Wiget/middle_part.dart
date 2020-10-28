import 'package:flutter/material.dart';
class MiddlePart extends StatelessWidget {
  final String tittle;
  final String image;
  final Function onTap;
  MiddlePart(
      {@required this.image, @required this.tittle, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.only(right: 20),
            height: 170,
            width: 140,
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
