import 'package:flutter/material.dart';

class DrawerContainer extends StatelessWidget {
  final String tittle;
  final Color color;
  final IconData icon;
  DrawerContainer({this.tittle, this.icon, this.color});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.blue,
      ),
      title: Text(
        tittle,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
