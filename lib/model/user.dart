import 'package:flutter/material.dart';

class UserData {
  final String email;
  final String fullname;
  final String password;
  final String image;
  final String phone;

  UserData({
    @required this.email,
    @required this.fullname,
    @required this.password,
    @required this.image,
    @required this.phone,
  });
}
