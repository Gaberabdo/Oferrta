import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-cubit.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-state.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/view/screens/Block-user-Screen.dart';


import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/component/component.dart';

import '../../../../../Features/Auth-feature/manger/model/user_model.dart';
import '../../../../../generated/l10n.dart';



class EditProfileAdmin extends StatelessWidget {
  EditProfileAdmin({Key? key, required this.model}) : super(key: key);

  final UserModel model;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlockUserCubit(),
      child: BlocConsumer<BlockUserCubit, BlockUserStates>(
        listener: (context, state) {
          if (state is UpdateSuccessUserDataState) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){

              return BlockUserScreen();
            }), (route) => false);
          }
        },
        builder: (context, state) {
          var cubit = BlockUserCubit.get(context);
          nameController.text = model.name!;
          phoneController.text = model.phone!;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text(
                S.of(context).edit_profile,
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
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: cubit.profileImage == null
                              ? NetworkImage(
                            '${model.image}',
                          ) as ImageProvider
                              : FileImage(cubit.profileImage!),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: CircleAvatar(
                            radius: 15,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt_outlined),
                              iconSize: 15,
                              onPressed: () {
                                cubit.pickImagesAdd();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormWidget(
                      maxLines: 2,
                      emailController: nameController,
                      prefixIcon: const Icon(
                        Icons.person,
                        size: 15,
                      ),
                      hintText: 'Please write your name',
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
                        Icons.call,
                        size: 15,
                      ),
                      hintText: 'Please write your phone',
                      validator: '',
                      obscureText: false,
                      icon: false,
                      enabled: true,
                    ),
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
                          if (cubit.profileImage == null) {
                            cubit.updateUser(
                              name: nameController.text,
                              image: model.image!,
                               uid: model.uId!,
                              phone: model.phone,
                            );
                          } else {
                            cubit.uploadImage(name: nameController.text,
                              phone: phoneController.text,
                              uid: model.uId!

                            );
                          }
                        },
                        child: Text(
                          S.of(context).editProfile,
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
              ),
            ),
          );
        },
      ),
    );
  }
}
