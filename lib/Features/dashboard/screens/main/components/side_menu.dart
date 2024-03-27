import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/core/constant.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: ColorStyle.primaryColor),
            child: Image.network("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Users",
            svgSrc: IconlyLight.user,
            press: () {},
          ),
          DrawerListTile(
            title: "Products",
            svgSrc: Icons.category_outlined,
            press: () {},
          ),

        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final dynamic title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      leading: Icon(svgSrc),
    );
  }
}
