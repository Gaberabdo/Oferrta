import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-state.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/generated/l10n.dart';

import '../../../../../Admin/Features/Block-user-feature/manger/block-user-cubit.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlockUserCubit, BlockUserStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = BlockUserCubit.get(context);
        return Drawer(
          elevation: 3,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: ColorStyle.primaryColor),
                child: Image.network("assets/images/offerta.png"),
              ),
              DrawerListTile(
                title: S.of(context).users,
                svgSrc: IconlyLight.user,
                press: () {
                  cubit.changeCurrent(index: 0);
                },
              ),
              DrawerListTile(
                title: S.of(context).products,
                svgSrc: Icons.production_quantity_limits_outlined,
                press: () {
                  cubit.changeCurrent(index: 1);
                },
              ),
              DrawerListTile(
                title: S.of(context).subscriptions,
                svgSrc: Icons.subscriptions,
                press: () {
                  cubit.changeCurrent(index: 4);
                },
              ),
              DrawerListTile(
                title:S.of(context).coupon,
                svgSrc: Icons.discount,
                press: () {
                  cubit.changeCurrent(index: 5);
                },
              ),
            ],
          ),
        );
      },
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
        style: FontStyleThame.textStyle(
          fontColor: Colors.black,
        ),
      ),
      leading: Icon(svgSrc),
    );
  }
}
