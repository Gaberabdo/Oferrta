import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Admin/Features/Subscriptions-Feature/manger/cubit/subscripation-cubit.dart';
import 'package:sell_4_u/Admin/Features/Subscriptions-Feature/manger/models/subscripation-model.dart';
import 'package:sell_4_u/Admin/Features/Subscriptions-Feature/view/edit-subscriopation.dart';
import 'package:sell_4_u/Features/Auth-feature/manger/model/user_model.dart';
import 'package:sell_4_u/core/constant.dart';

import '../../../Block-user-feature/view/screens/update-user-screen.dart';



class MyTableSubscripation extends StatelessWidget {
  final List<SubscripationModel> model;
  final SubscripationCubit cubit;

  const MyTableSubscripation({
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
                  label: Text(
                    'Discount',
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
                      DataCell(Text(
                        model.discount.toString(),
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
    required SubscripationModel model,
    required SubscripationCubit cubit,
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
                    cubit.deleteSubscription(
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
                      child: EditScubscripationAdmin(
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
