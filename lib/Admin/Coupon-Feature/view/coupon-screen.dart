import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart.';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_4_u/Admin/Coupon-Feature/view/widget/tabel-widget.dart';

import '../../../../generated/l10n.dart';
import '../manger/cubit/coupon-cubit.dart';
import '../manger/cubit/coupon-states.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CouponCubit()..getCoupons(),
      child: BlocBuilder<CouponCubit, CouponStates>(
        builder: (context, state) {
          var cubit = CouponCubit.get(context);
          return Scaffold(
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTableCoupon(
                  cubit: cubit,
                  model: cubit.coupons,
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showSubscriptionDialog(context, cubit);
              },
              backgroundColor: Colors.white,
              child: Icon(
                Icons.add_box,
                color: Colors.blue.shade300,
              ),
            ),
          );
        },
      ),
    );
  }

  void showSubscriptionDialog(BuildContext context, CouponCubit cubit) {
    TextEditingController textFieldController1 = TextEditingController();
    TextEditingController textFieldController2 = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(' New Coupon'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                  controller: textFieldController1,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter name';
                    }
                    return null;
                  },
                  keyboardAppearance: Brightness.dark,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: GoogleFonts.tajawal(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      // Set the border radius
                      borderSide: BorderSide.none, // Remove the border
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                  )),
              const SizedBox(
                height: 6,
              ),
              TextFormField(
                  controller: textFieldController2,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter Price';
                    }
                    return null;
                  },
                  keyboardAppearance: Brightness.dark,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    labelStyle: GoogleFonts.tajawal(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      // Set the border radius
                      borderSide: BorderSide.none, // Remove the border
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                  )),
              const SizedBox(
                height: 6,
              ),
            ],
          ),
          actions: <Widget>[
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  borderRadius: BorderRadius.circular(8)),
              child: TextButton(
                onPressed: () {
                  double price = double.parse(textFieldController2.text);

                  cubit.addCoupons(
                      name: textFieldController1.text, price: price);
                  Navigator.pop(context);
                },
                child: Text(
                  'Submit',
                  style: GoogleFonts.tajawal(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
