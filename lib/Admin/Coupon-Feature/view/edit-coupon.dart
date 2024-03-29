import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sell_4_u/Admin/Features/Subscriptions-Feature/manger/cubit/subscripation-cubit.dart';
import 'package:sell_4_u/Admin/Features/Subscriptions-Feature/manger/cubit/subscripation-states.dart';
import 'package:sell_4_u/Admin/Features/Subscriptions-Feature/manger/models/subscripation-model.dart';


import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/component/component.dart';

import '../../../../../Features/Auth-feature/manger/model/user_model.dart';
import '../../../../../generated/l10n.dart';
import '../manger/cubit/coupon-cubit.dart';
import '../manger/cubit/coupon-states.dart';
import '../manger/models/coupon-model.dart';



class EditCouponAdmin extends StatelessWidget {
  EditCouponAdmin({Key? key, required this.model}) : super(key: key);

  final CouponModel model;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CouponCubit(),
      child: BlocConsumer<CouponCubit, CouponStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          var cubit = CouponCubit.get(context);
          nameController.text = model.name!;
          phoneController.text = model.price.toString();

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text(
                'Edit Coupon',
                style: FontStyleThame.textStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [



                  SizedBox(
                    height: 50,
                    child: TextFormWidget(
                      maxLines: 2,
                      emailController: nameController,
                      prefixIcon: const Icon(
                        Icons.person,
                        size: 15,
                      ),
                      hintText: 'Please write  name',
                      validator: '',
                      obscureText: false,
                      icon: false,
                      enabled: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormWidget(
                      maxLines: 2,
                      emailController: phoneController,
                      prefixIcon: const Icon(
                        Icons.price_change,
                        size: 15,
                      ),
                      hintText: 'Please write price',
                      validator: '',
                      obscureText: false,
                      icon: false,
                      enabled: true,
                    ),
                  ),

                  Spacer(),
                  Container(
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorStyle.primaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: MaterialButton(
                      onPressed: () async {
double price=double.parse(phoneController.text);


cubit.updateCoupons(subscriptionId: model.id!, name: nameController.text, price: price);
Navigator.pop(context);
                      },
                      child: Text(
                        'Update',
                        style: FontStyleThame.textStyle(
                          fontSize: 16,
                          fontColor: Colors.white,
                        ),
                      ),
                    ),
                  )                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
