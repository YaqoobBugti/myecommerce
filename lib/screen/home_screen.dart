import 'package:flutter/material.dart';
import 'package:myecommerce/Wiget/appbar.dart';
import 'package:myecommerce/Wiget/child_fuction.dart';
import 'package:myecommerce/Wiget/drawer_widget.dart';
import 'package:myecommerce/Wiget/Bottom_Part_Container.dart';
import 'package:myecommerce/Wiget/man_fuction.dart';
import 'package:myecommerce/Wiget/woman_fuction.dart';
import 'package:myecommerce/provider/category_provider.dart';
import 'package:myecommerce/provider/provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    provider.allgetProduct();
    provider.getSeeAllProduct();
    MyCategory category = Provider.of<MyCategory>(context);
    category.allgetChildProduct();
    category.allgetManProduct();
    category.allgetWomanProduct();
    category.allgetChildCategories();
    category.allgetManCategories();
    category.allgetWomanCategories();
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: appBar(context),
      body: RefreshIndicator(
        color: Colors.blue,
        backgroundColor: Colors.white,
        onRefresh: () async {
          return await Future.delayed(
            Duration(
              seconds: 3,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ListView(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/cover.png'),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Categories",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ChildFuction(),
                    ManFuction(),
                    WomanFuction(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Featurd",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 495,
                child: BottomPartContainer(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
