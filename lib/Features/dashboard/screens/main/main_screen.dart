import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-cubit.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-state.dart';
import 'package:sell_4_u/Features/dashboard/controllers/MenuAppController.dart';
import 'package:sell_4_u/Features/dashboard/responsive.dart';
import 'package:sell_4_u/Features/dashboard/screens/dashboard/dashboard_screen.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlockUserCubit()..getAllUserData(),
      child: BlocConsumer<BlockUserCubit, BlockUserStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            key: context.read<MenuAppController>().scaffoldKey,
            drawer: SideMenu(),
            body: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // We want this side menu only for large screen
                  if (Responsive.isDesktop(context))
                    Expanded(
                      // default flex = 1
                      // and it takes 1/6 part of the screen
                      child: SideMenu(),
                    ),
                  Expanded(
                    // It takes 5/6 part of the screen
                    flex: 5,
                    child: DashboardScreen(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
