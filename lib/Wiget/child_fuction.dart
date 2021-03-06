import 'package:flutter/material.dart';
import 'package:myecommerce/Wiget/middle_part.dart';
import 'package:myecommerce/model/category.dart';

import 'package:myecommerce/provider/category_provider.dart';
import 'package:myecommerce/screen/category.dart';
import 'package:provider/provider.dart';

class ChildFuction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyCategory myCategory = Provider.of<MyCategory>(context);
    List<Categories> setCategoryProduct = myCategory.getallChildProduct;
    myCategory.allgetWomanProduct();
    return Row(
      children: setCategoryProduct.map(
        (element) {
          return MiddlePart(
            image: element.image,
            tittle: element.tittle,
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Category(
                    list: myCategory.getallChildCategories,
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
    );
  }
}
