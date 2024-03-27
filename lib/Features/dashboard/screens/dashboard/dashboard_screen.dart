import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/view/widget/my-table.dart';
import 'package:sell_4_u/Features/dashboard/responsive.dart';
import 'package:sell_4_u/Features/dashboard/screens/dashboard/components/my_fields.dart';

import '../../../../Admin/Features/Block-user-feature/manger/block-user-cubit.dart';
import '../../../../Admin/Features/Block-user-feature/manger/block-user-state.dart';
import '../../constants.dart';
import 'components/header.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlockUserCubit()..getAllUserData(),
      child: BlocConsumer<BlockUserCubit, BlockUserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlockUserCubit.get(context);
          var model = cubit.allUser;
          return SafeArea(
            child: SingleChildScrollView(
              primary: false,
              padding: EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Header(
                    cubit: cubit,
                  ),
                  SizedBox(height: defaultPadding),


                  MyTable(
                    model: (cubit.filteredUser.isEmpty) ? model : cubit.filteredUser,
                    cubit: cubit,
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
