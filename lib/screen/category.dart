import 'package:flutter/material.dart';
import 'package:myecommerce/Wiget/bottom_part.dart';
import 'package:myecommerce/Wiget/notifications.dart';
import 'package:myecommerce/model/product.dart';
import 'package:myecommerce/provider/category_provider.dart';
import 'package:myecommerce/screen/categories_search.dart';

import 'package:myecommerce/screen/detail_page.dart';

import 'package:myecommerce/screen/home_screen.dart';
import 'package:provider/provider.dart';

class Category extends StatelessWidget {
  final List<Product> list;
  Category({@required this.list});
  @override
  Widget build(BuildContext context) {
    MyCategory myCategory = Provider.of<MyCategory>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>HomeScreen()));
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              myCategory.getSearchList(
                list: list,
              );
              showSearch(
                context: context,
                delegate: CategoriesSearch(),
              );
            },
          ),
        Notifications(),
        ],
      ),
      body: SafeArea(
        child: GridView.count(
          // physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 0.87,
          crossAxisCount: 2,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          children: list.map((e) {
            return BottomPart(
              image: e.image,
              price: e.price,
              tittle: e.tittle,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      price: e.price,
                      tittle: e.tittle,
                      image: e.image,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
