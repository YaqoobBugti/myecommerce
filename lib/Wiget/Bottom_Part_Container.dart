import 'package:flutter/material.dart';
import 'package:myecommerce/Wiget/bottom_part.dart';
import 'package:myecommerce/model/product.dart';
import 'package:myecommerce/provider/provider.dart';

import 'package:myecommerce/screen/detail_page.dart';
import 'package:provider/provider.dart';

class BottomPartContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyProvider myProvider = Provider.of(context);
    List<Product> setProduct = myProvider.getallproduct;
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisSpacing: 20,
      childAspectRatio: 1.1,
      scrollDirection: Axis.horizontal,
      crossAxisCount: 2,
      children: setProduct.map(
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
