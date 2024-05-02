import 'dart:html';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-cubit.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-state.dart';
import 'package:sell_4_u/Features/Home-feature/models/category_model.dart';

import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/component/component.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../../Features/Auth-feature/manger/model/user_model.dart';
import '../../../../../generated/l10n.dart';

class AddCategory extends StatelessWidget {
  AddCategory({
    Key? key,
  }) : super(key: key);

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlockUserCubit(),
      child: BlocConsumer<BlockUserCubit, BlockUserStates>(
        listener: (context, state) {
          if (state is UpdateSuccessUserDataState) {
            Navigator.pop(context);
          }
          if (state is ImageUploadSuccess) {
            showTopSnackBar(
              Overlay.of(context),
              const CustomSnackBar.success(
                message: 'Image Add Success',
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = BlockUserCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 16,
                ),
              ),
              title: Text(
                'Add category',
                style: FontStyleThame.textStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Stack(
                      children: [
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
                      hintText: 'Please write category name',
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
                          if (cubit.profileImage != null &&
                              nameController.text.isNotEmpty) {
                            cubit.addCatImage(
                              name: nameController.text,
                              profileImage: cubit.profileImage!,
                            );
                          }
                        },
                        child: Text(
                          'Add',
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
