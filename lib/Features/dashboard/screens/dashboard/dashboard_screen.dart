import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Admin/Coupon-Feature/view/coupon-screen.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/view/widget/my-table.dart';
import 'package:sell_4_u/Admin/Features/Subscriptions-Feature/view/subscripation-screen.dart';
import 'package:sell_4_u/Admin/chat-feature/screens/admin/chat-details-admin.dart';
import 'package:sell_4_u/Features/dashboard/responsive.dart';
import 'package:sell_4_u/Features/dashboard/screens/dashboard/cat_banner_dash.dart';
import 'package:sell_4_u/Features/dashboard/screens/dashboard/components/home_feeds_details_dash.dart';
import '../../../../Admin/Features/Block-user-feature/manger/block-user-cubit.dart';
import '../../../../Admin/Features/Block-user-feature/manger/block-user-state.dart';
import '../../../Auth-feature/manger/model/user_model.dart';
import '../../../Home-feature/view/screens/home/panner_cat.dart';
import '../../constants.dart';
import 'components/header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlockUserCubit, BlockUserStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BlockUserCubit.get(context);
        var model = cubit.allUser;

        List<Widget> widgets = [
          MyTable(
            model: (cubit.filteredUser.isEmpty) ? model : cubit.filteredUser,
            cubit: cubit,
          ),
          const BannerCatDash(),
          HomeFeedsDetailsDash(
            productId: cubit.productId ?? '',
            uid: cubit.uidOwner ?? '',
            value: cubit.value,
            catId: cubit.catId ?? '',
            catProId: cubit.catProId ?? '',
          ),
          ChatDetailsAdmin(
            model: cubit.activeUserChat ?? UserModel(),
          ),
          const SubscripationScreen(),
          const CouponScreen()
        ];
        return Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(
                cubit: cubit,
              ),
              const SizedBox(height: defaultPadding),
              const SizedBox(height: defaultPadding),
              Expanded(
                child: widgets[cubit.current],
              ),
            ],
          ),
        );
      },
    );
  }
}
