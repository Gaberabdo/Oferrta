import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-cubit.dart';
import 'package:sell_4_u/Features/dashboard/controllers/MenuAppController.dart';
import 'package:sell_4_u/Features/dashboard/responsive.dart';
import 'package:sell_4_u/core/constant.dart';

import '../../../../Auth-feature/manger/model/user_model.dart';
import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final BlockUserCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuAppController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(
          child: SearchField(
            cubit: cubit,
          ),
        ),
        ProfileCard(
          cubit: cubit,
        )
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final BlockUserCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: ColorStyle.gray,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.person,
            size: 35,
          ),
          if (!Responsive.isMobile(context))
            Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text(cubit.activeUser.name ?? 'Admin account'),
            ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final BlockUserCubit cubit;

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: true,
      onChanged: (value) {
        cubit.filterUsers(value);
        if (value.isEmpty) {
          cubit.filteredUser.clear();
        }
      },
      decoration: const InputDecoration(
        hintText: "Search",
        // fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
