import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/Auth-feature/manger/model/user_model.dart';
import 'package:sell_4_u/core/constant.dart';

import '../../../../../core/helper/component/component.dart';
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
                  label: Text(
                    'Platform',
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
                      DataCell(
                        _buildCircleAvatar(
                          model.image.toString(),
                        ),
                      ),
                      DataCell(Text(
                        model.email.toString(),
                        textAlign: TextAlign.center,
                        style: FontStyleThame.textStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      )),
                      DataCell(Text(
                        model.phone.toString(),
                        textAlign: TextAlign.center,
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
                      DataCell(Text(
                        model.platform ?? '--',
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
    required UserModel model,
    required BlockUserCubit cubit,
  }) {
    final titleController = TextEditingController();
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
        Text('Delete User',style: TextStyle(
          fontSize:12,
        ),),
        Expanded(
          child: IconButton(
            onPressed: () {
              if (model.blocked == true) {
                cubit.unblock(model.uId!);
              } else {
                cubit.blockAlowes(model.uId!,);
              }
            },
            icon: const Icon(
              Icons.block,
              color: Colors.blue,
            ),
          ),
        ),
        Text('Block User',style: TextStyle(
          fontSize:12,
        ),),
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
        Text('Edit User',style: TextStyle(
          fontSize:12,
        ),),
        Expanded(
          child: IconButton(
            onPressed: () {
              cubit.changeCurrent(index: 3, model: model);
            },
            icon: Icon(
              IconlyLight.chat,
              color: ColorStyle.secondColor,
            ),
          ),
        ),
        Text('Chat User',style: TextStyle(
          fontSize:12,
        ),),
        Expanded(
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      children: [
                        Text(
                          'Temporary block',
                          style: FontStyleThame.textStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    content: SizedBox(
                        width: 400,
                        height: 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 50,
                              child: TextFormWidget(
                                maxLines: 2,
                                emailController: titleController,
                                keyboardType: TextInputType.number,
                                prefixIcon: const Icon(
                                  Icons.title,
                                  size: 15,
                                ),
                                hintText: 'Enter number of days',
                                validator: '',
                                obscureText: false,
                                icon: false,
                                enabled: true,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Spacer(),
                            ConditionalBuilder(
                              condition: !cubit.isUpload,
                              builder: (context) => Container(
                                height: 45,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: ColorStyle.primaryColor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: MaterialButton(
                                  onPressed: () async {
                                    cubit.block(
                                      model.uId!,
                                      int.parse(titleController.text),
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Confirm block',
                                    style: FontStyleThame.textStyle(
                                      fontSize: 16,
                                      fontColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              fallback: (context) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: ColorStyle.primaryColor,
                                  ),
                                );
                              },
                            ),
                          ],
                        )),
                  );
                },
              );
            },
            icon: Icon(
              Icons.timer,
              color: ColorStyle.primaryColor,
            ),
          ),
        ),
        Text('Temporary Block',style: TextStyle(
          fontSize:12,
        ),),
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
