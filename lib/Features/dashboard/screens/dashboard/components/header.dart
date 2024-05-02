import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-cubit.dart';
import 'package:sell_4_u/Features/Home-feature/view/screens/home/create_post.dart';
import 'package:sell_4_u/Features/dashboard/controllers/MenuAppController.dart';
import 'package:sell_4_u/Features/dashboard/responsive.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/main/cubit/main_cubit.dart';
import 'package:sell_4_u/generated/l10n.dart';

import '../../../../../core/helper/component/component.dart';
import '../../../../Auth-feature/manger/model/user_model.dart';
import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final BlockUserCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuAppController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            cubit.titles[cubit.current],
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(
          child: SearchField(
            cubit: cubit,
          ),
        ),
        ProfileCard(
          cubit: cubit,
        )
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final BlockUserCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: ColorStyle.gray,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.person,
            size: 35,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: PopupMenuButton<int>(
              tooltip: S.of(context).lang,
              onCanceled: () {
                Navigator.of(context);
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    onTap: () {
                      MainCubit.get(context).changeAppLang(langMode: 'en');
                    },
                    child: Text(
                      S.of(context).english,
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    onTap: () {
                      MainCubit.get(context).changeAppLang(langMode: 'ar');
                    },
                    child: Text(
                      S.of(context).arabic,
                    ),
                  ),
                ];
              },
              child: const Icon(Icons.language),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  SearchField({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  final BlockUserCubit cubit;
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          child: IconButton(
            tooltip: S.of(context).createPost,
            icon: const Icon(
              Icons.upload,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: SizedBox(
                      width: Responsive.isMobile(context)
                          ? MediaQuery.sizeOf(context).width
                          : 777,
                      height: 650,
                      child: CreatePost(),
                    ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(
          width: defaultPadding,
        ),
        CircleAvatar(
          child: IconButton(
            icon: const Icon(
              Icons.notification_add,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      children: [
                        Text(
                          S.of(context).notifications,
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
                                prefixIcon: const Icon(
                                  Icons.title,
                                  size: 15,
                                ),
                                hintText: S.of(context).notiTitle,
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
                                emailController: bodyController,
                                prefixIcon: const Icon(
                                  Icons.bolt,
                                  size: 15,
                                ),
                                hintText: S.of(context).notiBody,
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
                                    cubit
                                        .sendNot(
                                      body: bodyController.text,
                                      title: titleController.text,
                                    )
                                        .then((value) {
                                      titleController.clear();
                                      bodyController.clear();
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text(
                                    S.of(context).sendNotif,
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
          ),
        ),
        SizedBox(
          width: defaultPadding,
        ),
        Expanded(
          child: TextField(
            enabled: true,
            onChanged: (value) {
              cubit.filterUsers(value);
              if (value.isEmpty) {
                cubit.filteredUser.clear();
              }
            },
            decoration: InputDecoration(
              hintText: S.of(context).search,
              // fillColor: secondaryColor,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
