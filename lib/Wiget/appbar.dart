import 'package:flutter/material.dart';
import 'package:myecommerce/Wiget/notifications.dart';
import 'package:myecommerce/screen/search.dart';
AppBar appBar(context) {
  return AppBar(
    elevation: 0.0,
    backgroundColor: Theme.of(context).primaryColor,
    centerTitle: true,
    title: Text("Daraz"),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch(
            context: context,
            delegate: Search(),
          );
        },
      ),
     Notifications(),
    ],
  );
}
