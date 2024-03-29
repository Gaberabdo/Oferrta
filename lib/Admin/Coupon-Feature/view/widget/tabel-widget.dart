import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/core/constant.dart';

import '../../manger/cubit/coupon-cubit.dart';
import '../../manger/models/coupon-model.dart';
import '../edit-coupon.dart';



class MyTableCoupon extends StatelessWidget {
  final List<CouponModel> model;
  final CouponCubit cubit;

  const MyTableCoupon({
    Key? key,
    required this.model,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.white,
            elevation: 3,
            borderRadius: BorderRadius.circular(12.0),
            child: DataTable(
              headingRowHeight: 50,
              border: TableBorder.all(
                style: BorderStyle.solid,
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                width: 2,
              ),
              dataRowHeight: 80,
              dividerThickness: 0.0,
              columns: [
                DataColumn(
                  label: Text(
                    'Name',
                    textAlign: TextAlign.center,
                    style: FontStyleThame.textStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Price',
                    textAlign: TextAlign.center,
                    style: FontStyleThame.textStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),



                DataColumn(
                  label: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 50),
                    child: Text(
                      'Action',
                      textAlign: TextAlign.center,
                      style: FontStyleThame.textStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
              rows: model.map(
                    (model) {
                  return DataRow(
                    cells: [
                      DataCell(Text(
                        model.name.toString(),
                        textAlign: TextAlign.center,
                        style: FontStyleThame.textStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      )),
                      DataCell(Text(
                        model.price.toString(),
                        textAlign: TextAlign.center,
                        style: FontStyleThame.textStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      )),


                      DataCell(
                        buildAction(
                          context: context,
                          model: model,
                          cubit: cubit,
                        ),
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAction({
    required BuildContext context,
    required CouponModel model,
    required CouponCubit cubit,
  }) {
    return Row(
      children: [
        Expanded(
          child: IconButton(
            onPressed: () async {
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  width: 400,
                  animType: AnimType.rightSlide,
                  title: 'Warning',
                  desc: 'Are You Sure To Delete This Subscripation...?',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    print('iiiiiiiiiiiiiiiiiiiiiiiiiiid${model.id}');
                    cubit.deleteCoupons(
                     model.id!
                    );
                  }).show();
            },
            icon: const Icon(
              IconlyBold.delete,
              color: Colors.red,
            ),
          ),
        ),

        Expanded(
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: SizedBox(
                      width: 400,
                      height: 500,
                      child: EditCouponAdmin(
                        model: model,
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              IconlyLight.edit,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

}
