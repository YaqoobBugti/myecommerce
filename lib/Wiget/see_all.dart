import 'package:flutter/material.dart';
import 'package:myecommerce/Wiget/bottom_part.dart';
import 'package:myecommerce/model/product.dart';
import 'package:myecommerce/provider/provider.dart';

import 'package:myecommerce/screen/detail_page.dart';
import 'package:provider/provider.dart';
class SeeAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyProvider seeAll = Provider.of(context);
    List<Product> setSeeAllProduct = seeAll.getSeenAllProduct;
    return GridView.count(
      childAspectRatio: 0.69,
      crossAxisCount: 2,
      padding: EdgeInsets.only(left: 20),
      children: setSeeAllProduct.map(
        (element) {
          return BottomPart(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    image: element.image,
                    price: element.price,
                    tittle: element.tittle,
                  ),
                ),
              );
            },
            image: element.image,
            price: element.price,
            tittle: element.tittle,
          );
        },
      ).toList(),
    );
  }
}