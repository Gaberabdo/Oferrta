import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Admin/Coupon-Feature/view/user-uses-screen.dart';
import 'package:sell_4_u/core/constant.dart';

import '../../manger/cubit/coupon-cubit.dart';
import '../../manger/models/coupon-model.dart';
import '../edit-coupon.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class MyTableCouponHistory extends StatelessWidget {
  final List<CouponModel> model;
  final CouponCubit cubit;

  const MyTableCouponHistory({
    Key? key,
    required this.model,
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Wrap with SingleChildScrollView here
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.white,
          elevation: 3,
          borderRadius: BorderRadius.circular(12.0),
          child: SingleChildScrollView(
            // Move SingleChildScrollView inside Material widget
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
                    'User Name',
                    textAlign: TextAlign.center,
                    style: FontStyleThame.textStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Data Using',
                    textAlign: TextAlign.center,
                    style: FontStyleThame.textStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              rows: model.map(
                (model) {
                  String formattedDateTime =
                      DateFormat('yyyy-MM-dd ').format(model.usedAt!.toDate());

                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          model.username.toString(),
                          textAlign: TextAlign.center,
                          style: FontStyleThame.textStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      DataCell(Text(
                        formattedDateTime.toString(),
                        textAlign: TextAlign.center,
                        style: FontStyleThame.textStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      )),
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

}
