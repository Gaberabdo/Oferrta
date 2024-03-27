import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/Auth-feature/manger/model/user_model.dart';
import 'package:sell_4_u/core/constant.dart';

import '../../manger/block-user-cubit.dart';
import '../screens/update-user-screen.dart';

class MyTable extends StatelessWidget {
  final List<UserModel> model;
  final BlockUserCubit cubit;

  const MyTable({
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
                    'Image',
                    textAlign: TextAlign.center,
                    style: FontStyleThame.textStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Email',
                    textAlign: TextAlign.center,
                    style: FontStyleThame.textStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Phone',
                    textAlign: TextAlign.center,
                    style: FontStyleThame.textStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Blocked',
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
              rows: model.map((model) {
                return DataRow(cells: [
                  DataCell(Text(model.name.toString())),
                  DataCell(
                    _buildCircleAvatar(
                      model.image.toString(),
                    ),
                  ),
                  DataCell(Text(
                    model.email.toString(),
                    style: FontStyleThame.textStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
                  DataCell(Text(
                    model.phone.toString(),
                    style: FontStyleThame.textStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  )),
                  DataCell(model.blocked == true
                      ? Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'True',
                              textAlign: TextAlign.center,
                              style: FontStyleThame.textStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'False',
                              textAlign: TextAlign.center,
                              style: FontStyleThame.textStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        )),
                  DataCell(buildAction(
                    context: context,
                    model: model,
                    cubit: cubit,
                  )),
                ]);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAction({
    required BuildContext context,
    required UserModel model,
    required BlockUserCubit cubit,
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
                  desc: 'Are You Sure To Delete This User...?',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    cubit.deleteUser(
                      uid: model.uId!,
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
              if (model.blocked == true) {
                cubit.unblock(model.uId!);
              } else {
                cubit.block(model.uId!);
              }
            },
            icon: const Icon(
              Icons.block,
              color: Colors.blue,
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
                      child: EditProfileAdmin(
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

  Widget _buildCircleAvatar(String image) {
    return CircleAvatar(
      backgroundColor: Colors.grey,
      radius: 20,
      backgroundImage: NetworkImage(image),
    );
  }
}
