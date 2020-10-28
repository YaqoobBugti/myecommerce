import 'package:flutter/material.dart';
import 'package:myecommerce/Wiget/bottom_part.dart';
import 'package:myecommerce/model/product.dart';
import 'package:myecommerce/provider/category_provider.dart';
import 'package:myecommerce/screen/detail_page.dart';
import 'package:provider/provider.dart';

class CategoriesSearch extends SearchDelegate<Product> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    MyCategory provider = Provider.of<MyCategory>(context, listen: false);
    List<Product> _searchfoodList = provider.searchCategoryList(query);

    return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 0.87,
        crossAxisCount: 2,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: _searchfoodList.map<Widget>(
          (e) {
            return BottomPart(
              image: e.image,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      image: e.image,
                      price: e.price,
                      tittle: e.tittle,
                    ),
                  ),
                );
              },
              price: e.price,
              tittle: e.tittle,
            );
          },
        ).toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    MyCategory provider = Provider.of<MyCategory>(context, listen: false);
    List<Product> _searchfoodList = provider.searchCategoryList(query);

    return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 0.87,
        crossAxisCount: 2,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: _searchfoodList.map<Widget>(
          (e) {
            return BottomPart(
              image: e.image,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      image: e.image,
                      price: e.price,
                      tittle: e.tittle,
                    ),
                  ),
                );
              },
              price: e.price,
              tittle: e.tittle,
            );
          },
        ).toList());
  }
}
