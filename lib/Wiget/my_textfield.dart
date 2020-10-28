import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MYTextField extends StatelessWidget {
  final String hintText;
  final bool obscuretext;
  final IconData eyeicon;
  final TextInputType keyboard;
  final TextEditingController controller;
  MYTextField(
      {this.hintText,
      this.controller,
      this.obscuretext,
      this.keyboard,
      this.eyeicon});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        keyboardType: keyboard,
        controller: controller,
        obscureText: obscuretext,
        decoration: InputDecoration(
          suffixIcon: Icon(eyeicon),
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(6),
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
