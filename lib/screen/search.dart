import 'package:flutter/material.dart';
import 'package:myecommerce/Wiget/bottom_part.dart';
import 'package:myecommerce/model/product.dart';
import 'package:myecommerce/provider/provider.dart';

import 'package:myecommerce/screen/detail_page.dart';
import 'package:provider/provider.dart';

class Search extends SearchDelegate<Product> {
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
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    List<Product> _searchfoodList = provider.search(query);

    return GridView.count(
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 0.87,
        crossAxisCount: 2,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: _searchfoodList
            .map<Widget>(
              (e) => BottomPart(
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
              ),
            )
            .toList());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context, listen: false);
    List<Product> _searchfoodList = provider.search(query);
    return Container(
      color: Theme.of(context).primaryColor,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 0.87,
        crossAxisCount: 2,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: _searchfoodList
            .map<Widget>(
              (e) => BottomPart(
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
              ),
            ).toList(),
      ),
    );
  }
}
