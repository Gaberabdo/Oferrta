import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting
import 'package:sell_4_u/Admin/Coupon-Feature/manger/cubit/coupon-states.dart';
import 'package:sell_4_u/Admin/Coupon-Feature/view/widget/hitory_copon.dart';

import '../../../Features/dashboard/constants.dart';
import '../../../Features/dashboard/screens/dashboard/components/header.dart';
import '../../Features/Block-user-feature/manger/block-user-cubit.dart';
import '../manger/cubit/coupon-cubit.dart';

class UserUsesScreen extends StatelessWidget {
  UserUsesScreen({required this.id});

  String id;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CouponCubit()..getUserUses(id: id),
        ),
        BlocProvider(
          create: (context) => BlockUserCubit(),
        ),
      ],
      child: BlocConsumer<CouponCubit, CouponStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CouponCubit.get(context);
          var bloCubit = BlockUserCubit.get(context);
          return Scaffold(

            body: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Header(
                    cubit: bloCubit,
                  ),
                ),
                const SizedBox(height: defaultPadding),
                const SizedBox(height: defaultPadding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyTableCouponHistory(
                      cubit: cubit,
                      model: cubit.useruses,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
