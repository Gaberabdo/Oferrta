import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sell_4_u/Features/Auth-feature/presentation/pages/login/login_screen.dart';
import 'package:sell_4_u/Features/setting/Cubit/setting_state.dart';
import 'package:sell_4_u/Features/setting/view/screens/edit_profile.dart';
import 'package:sell_4_u/Features/setting/view/screens/recently_viewed.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/component/component.dart';
import 'package:sell_4_u/core/helper/main/cubit/main_cubit.dart';

import '../../../../core/helper/cache/cache_helper.dart';
import '../../../../generated/l10n.dart';
import '../../Cubit/setting_cubit.dart';
import 'inbox_list.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit()..getUser(),
      child: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = SettingCubit.get(context);
          var userModel = cubit.model!;
          return Scaffold(

            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    if (CacheHelper.getData(key: "uId") == null ||
                        cubit.model.image == null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                'https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg',
                              ),
                            ),

                          Container(
                            decoration: BoxDecoration(
                              color: ColorStyle.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: MaterialButton(onPressed: (){
                              navigatorTo(context, LoginScreen());
                            },
                              child: Text(S.of(context).signIn,style: GoogleFonts.tajawal(
                                color:Colors.white,
                                fontSize:16,
                                fontWeight:FontWeight.bold
                              ),),

                            ),
                          )
                          ],
                        ),
                      )
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(userModel!.image!),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userModel!.name!,
                                style: FontStyleThame.textStyle(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      S.of(context).myAccount,
                      style: FontStyleThame.textStyle(
                        fontColor: ColorStyle.primaryColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (CacheHelper.getData(key: "uId") == null) {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return LoginScreen();
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return EditProfile(
                                  model: cubit.model,
                                );
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(242, 242, 242, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.edit,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                S.of(context).edit_profile,
                                style: FontStyleThame.textStyle(),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (CacheHelper.getData(key: "uId") == null) {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return LoginScreen();
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return const InBoxList();
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(242, 242, 242, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.library_books_sharp,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                S.of(context).my_listings,
                                style: FontStyleThame.textStyle(),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (CacheHelper.getData(key: "uId") == null) {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return LoginScreen();
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return const RecentlyViewed();
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(242, 242, 242, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.favorite_border,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                S.of(context).my_favorites,
                                style: FontStyleThame.textStyle(),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      S.of(context).setting,
                      style: FontStyleThame.textStyle(
                        fontColor: ColorStyle.primaryColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(242, 242, 242, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.language,
                              size: 22,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              S.of(context).language,
                              style: FontStyleThame.textStyle(),
                            ),
                            const Spacer(),
                            PopupMenuButton<int>(
                              onCanceled: () {
                                Navigator.of(context);
                              },
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    value: 1,
                                    onTap: () {
                                      MainCubit.get(context)
                                          .changeAppLang(langMode: 'en');
                                    },
                                    child: Text(
                                      S.of(context).english,
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    onTap: () {
                                      MainCubit.get(context)
                                          .changeAppLang(langMode: 'ar');
                                    },
                                    child: Text(
                                      S.of(context).arabic,
                                    ),
                                  ),
                                ];
                              },
                              child: const Icon(Icons.more_horiz),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    GestureDetector(
                      onTap: () {
                        CacheHelper.clearData().then((value) {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return LoginScreen();
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;
                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                var offsetAnimation = animation.drive(tween);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                            ),
                          );
                          FirebaseAuth.instance.signOut();
                        });
                      },
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(242, 242, 242, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.logout,
                                size: 22,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                S.of(context).logout,
                                style: FontStyleThame.textStyle(),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
