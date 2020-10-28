import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myecommerce/Wiget/drawer_container.dart';
import 'package:myecommerce/model/user.dart';
import 'package:myecommerce/provider/provider.dart';

import 'package:myecommerce/screen/check_out.dart';
import 'package:myecommerce/screen/about.dart';
import 'package:myecommerce/screen/contect.dart';

import 'package:myecommerce/screen/home_screen.dart';
import 'package:myecommerce/screen/login.dart';
import 'package:myecommerce/screen/profile/profilepage.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  Widget callDrawerContainer(
      {@required IconData icon,
      @required String tittle,
      @required Function ontap,
      context}) {
    return GestureDetector(
      onTap: ontap,
      child: DrawerContainer(
        icon: icon,
        tittle: tittle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    provider.fetchUserData();
    UserData currentUser = provider.getCurrrentUser;
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                currentUser.fullname,
              ),
              accountEmail: Text(
                currentUser.email,
              ),
              currentAccountPicture: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  backgroundImage: currentUser.image == null
                      ? AssetImage('images/profile.jpg')
                      : NetworkImage(currentUser.image),
                ),
              ),
            ),
            callDrawerContainer(
              icon: Icons.home,
              ontap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              tittle: 'Home',
              context: context,
            ),
            callDrawerContainer(
              icon: Icons.shopping_cart,
              ontap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => CheckOut()));
              },
              tittle: 'CheckOut',
              context: context,
            ),
            callDrawerContainer(
              icon: Icons.person,
              ontap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              tittle: 'Profile',
              context: context,
            ),
            callDrawerContainer(
              icon: Icons.help,
              ontap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => About()));
              },
              tittle: 'About',
              context: context,
            ),
            callDrawerContainer(
              icon: Icons.phone,
              ontap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Contect()));
              },
              tittle: 'Contect us',
              context: context,
            ),
            callDrawerContainer(
              icon: Icons.exit_to_app,
              ontap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Login()));
              },
              tittle: 'Logout',
              context: context,
            ),
          ],
        ),
      ),
    );
  }
}
