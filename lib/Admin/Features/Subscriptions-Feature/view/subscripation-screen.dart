import 'package:flutter/material.dart.';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_4_u/Admin/Features/Subscriptions-Feature/manger/cubit/subscripation-cubit.dart';
import 'package:sell_4_u/Admin/Features/Subscriptions-Feature/manger/cubit/subscripation-states.dart';
import 'package:sell_4_u/Admin/Features/Subscriptions-Feature/view/widget/tabel-widget.dart';
import 'package:sell_4_u/generated/l10n.dart';

class SubscripationScreen extends StatelessWidget {
  const SubscripationScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscripationCubit()..getSubscriptions(),
      child: BlocBuilder<SubscripationCubit, SubscripationStates>(
        builder: (context, state) {
          var cubit = SubscripationCubit.get(context);
          return Scaffold(
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTableSubscripation(
                  cubit: cubit,
                  model: cubit.subscriptions,
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

  void showSubscriptionDialog(BuildContext context, SubscripationCubit cubit) {
    TextEditingController textFieldController1 = TextEditingController();
    TextEditingController textFieldController2 = TextEditingController();
    TextEditingController textFieldController3 = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text( S.of(context).newSubscrip,),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                  controller: textFieldController1,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return  S.of(context).pleaseName;
                    }
                    return null;
                  },
                  keyboardAppearance: Brightness.dark,
                  decoration: InputDecoration(
                    labelText: S.of(context).Name,
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
                      return  S.of(context).Price;
                    }
                    return null;
                  },
                  keyboardAppearance: Brightness.dark,
                  decoration: InputDecoration(
                    labelText: S.of(context).Price,
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
                  controller: textFieldController3,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return  S.of(context).enterDiscount;
                    }
                    return null;
                  },
                  keyboardAppearance: Brightness.dark,
                  decoration: InputDecoration(
                    labelText:  S.of(context).disount,
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
                  double discount = double.parse(textFieldController3.text);
                  cubit.addSubscription(
                      name: textFieldController1.text,
                      price: price,
                      discount: discount);
                  Navigator.pop(context);
                },
                child: Text(
                  S.of(context).submit,
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
