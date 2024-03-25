import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/Auth-feature/presentation/pages/login/login_screen.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/Layout_cubit/home-cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/Layout_cubit/home-state.dart';
import 'package:sell_4_u/Features/Home-feature/view/screens/home/create_post.dart';
import 'package:sell_4_u/Features/setting/view/screens/search_screen.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/cache/cache_helper.dart';
import 'package:sell_4_u/core/helper/component/component.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../core/helper/main/cubit/main_cubit.dart';
import '../../../core/responsive_screen.dart';
import '../../../generated/l10n.dart';

class LayoutScreen extends StatelessWidget {
  LayoutScreen({super.key});

  final _controller = SideMenuController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getUser(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          var userModel = cubit.model!;
          return ResponsiveScreen(
            mobileScreen: Scaffold(

              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.selectedIndex,
                onTap: (value) {
                  cubit.onItemTapped(value);
                  if (cubit.selectedIndex == 2 &&
                      CacheHelper.getData(key: 'uId') != null) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const CreatePost();
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
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
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );

                    cubit.onItemTapped(0);
                  } else if (cubit.selectedIndex == 2) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return LoginScreen();
                        },
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
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
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );
                    cubit.onItemTapped(0);
                  }
                },
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(IconlyLight.home),
                    label: S.of(context).home,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.sell_outlined),
                    label: S.of(context).commercials,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.add_to_photos_outlined),
                    label: S.of(context).post_an_ad,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.account_circle_outlined),
                    label: S.of(context).account,
                  ),
                ],
              ),
              body: cubit.screens[cubit.selectedIndex],
            ),
            desktopScreen: Scaffold(
              body: Row(
                children: [
                  SideMenu(
                    controller: _controller,
                    backgroundColor: ColorStyle.primaryColor,
                    mode: SideMenuMode.open,
                    builder: (data) {
                      return SideMenuData(
                        header: Column(
                          children: [
                            const SizedBox(
                              height: 14,
                            ),
                            if (CacheHelper.getData(key: "uId") == null ||
                                cubit.model.image == null)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      'https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'login to buy and sell anything',
                                    style: FontStyleThame.textStyle(
                                      fontSize: 14,
                                      fontColor: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                            else
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        NetworkImage(userModel!.image!),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userModel!.name!,
                                        style: FontStyleThame.textStyle(
                                          fontSize: 14,
                                          fontColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            const SizedBox(
                              height: 14,
                            ),
                          ],
                        ),
                        items: [
                          SideMenuItemDataTile(
                            isSelected: cubit.selectedIndex == 0,
                            onTap: () {
                              cubit.onItemTapped(0);
                            },
                            title: S.of(context).home,
                            hoverColor: Colors.blue,
                            titleStyle: FontStyleThame.textStyle(
                              fontSize: 14,
                              fontColor: Colors.white,
                            ),
                            icon: const Icon(IconlyLight.home),
                            selectedIcon: const Icon(IconlyBold.home),
                          ),
                          SideMenuItemDataTile(
                            isSelected: cubit.selectedIndex == 1,
                            onTap: () {
                              cubit.onItemTapped(1);
                            },
                            title: S.of(context).commercials,
                            hoverColor: Colors.blue,
                            titleStyle: FontStyleThame.textStyle(
                              fontSize: 14,
                              fontColor: Colors.white,
                            ),
                            icon: const Icon(Icons.sell_outlined),
                            selectedIcon: const Icon(Icons.sell_rounded),
                          ),
                          SideMenuItemDataTile(
                            isSelected: cubit.selectedIndex == 2,
                            onTap: () {
                              cubit.onItemTapped(2);
                              if (cubit.selectedIndex == 2 &&
                                  CacheHelper.getData(key: 'uId') != null) {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return const CreatePost();
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = const Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                  ),
                                );

                                cubit.onItemTapped(0);
                              } else if (cubit.selectedIndex == 2) {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return LoginScreen();
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = const Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                  ),
                                );
                                cubit.onItemTapped(0);
                              }
                            },
                            title: S.of(context).post_an_ad,
                            hoverColor: Colors.blue,
                            titleStyle: FontStyleThame.textStyle(
                              fontSize: 14,
                              fontColor: Colors.white,
                            ),
                            icon: const Icon(Icons.add_to_photos_outlined),
                            selectedIcon:
                                const Icon(Icons.add_to_photos_rounded),
                          ),

                           SideMenuItemDataTitle(

                            title: S.of(context).setting,
                            textAlign: TextAlign.center,
                             titleStyle: FontStyleThame.textStyle(
                               fontSize: 14,
                               fontColor: Colors.white,
                             ),
                          ),

                          SideMenuItemDataTile(
                            isSelected: cubit.selectedIndex == 3,
                            onTap: () {
                              cubit.onItemTapped(3);
                            },
                            title: S.of(context).account,
                            hoverColor: Colors.blue,
                            titleStyle: const TextStyle(color: Colors.white),
                            icon: const Icon(Icons.account_circle_outlined),
                            selectedIcon:
                                const Icon(Icons.account_circle_rounded),
                          ),
                          SideMenuItemDataTile(
                            isSelected: cubit.selectedIndex == 4,
                            onTap: () {
                              CacheHelper.clearData().then((value) {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return LoginScreen();
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = const Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                    transitionDuration:
                                        const Duration(milliseconds: 500),
                                  ),
                                );
                              });
                            },
                            title: S.of(context).logout,
                            hoverColor: Colors.blue,
                            titleStyle: FontStyleThame.textStyle(
                              fontSize: 14,
                              fontColor: Colors.white,
                            ),
                            icon: const Icon(Icons.logout),
                            selectedIcon:
                                const Icon(Icons.logout_rounded),
                          ),
                        ],
                      );
                    },
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: AppBar(
                            elevation: 1,
                            backgroundColor: Colors.white,
                            centerTitle: true,
                            automaticallyImplyLeading: false,
                            title: cubit.selectedIndex == 4
                                ? null
                                : InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                              secondaryAnimation) {
                                            return SearchScreen();
                                          },
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var begin = const Offset(1.0, 0.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;
                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));
                                            var offsetAnimation =
                                                animation.drive(tween);
                                            return SlideTransition(
                                              position: offsetAnimation,
                                              child: child,
                                            );
                                          },
                                          transitionDuration:
                                              const Duration(milliseconds: 500),
                                        ),
                                      );
                                    },
                                    child: TextFormWidget(
                                      emailController: TextEditingController(),
                                      prefixIcon: const Icon(
                                        IconlyLight.search,
                                        size: 15,
                                      ),
                                      hintText: S.of(context).search,
                                      validator: '',
                                      obscureText: false,
                                      icon: false,
                                      enabled: false,
                                    ),
                                  ),
                          ),
                        ),
                        Expanded(
                          child: cubit.screens[cubit.selectedIndex],
                        ),
                      ],
                    ),
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
