import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_state.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/helper/component/component.dart';
import '../../../../../generated/l10n.dart';
import '../../../../setting/view/screens/search_screen.dart';
import 'feeds_details.dart';

class BannerCat extends StatelessWidget {
  const BannerCat({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedsCubit()..getCategory(),
      child: BlocConsumer<FeedsCubit, FeedsState>(
        listener: (context, state) {
          var cubit = FeedsCubit.get(context);

          if (state is GetCategorySuccess) {
            cubit.catIdString = cubit.catModelIdes.first;
            cubit.getCategoryDetails(cubit.catModelIdes.first);
          }
        },
        builder: (context, state) {
          var cubit = FeedsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              backgroundColor: Colors.white,
              centerTitle: true,
              automaticallyImplyLeading: false,
              title:  InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) {
                        return SearchScreen();
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  (cubit.catModel.isNotEmpty)
                      ? SizedBox(
                          height: 60,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    print(cubit.catIdString);

                                    cubit.getCategoryDetails(
                                        cubit.catModelIdes[index]);
                                    cubit.catIdString =
                                        cubit.catModelIdes[index];
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          style: BorderStyle.solid,
                                          color: Colors.black,
                                          width: 1,
                                        )),
                                    child: Center(
                                      child: Text(
                                        cubit.catModel[index].categoryName!,
                                        style: FontStyleThame.textStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          fontColor: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: cubit.catModel.length,
                          ),
                        )
                      : SizedBox(
                          height: 40,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FadeIn(
                                  duration: const Duration(milliseconds: 400),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade500,
                                    child: Container(
                                      height: 20,
                                      width: 120,
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: 10,
                          ),
                        ),
                  const SizedBox(
                    height: 12,
                  ),
                  (state is GetCategoryLoading)
                      ? GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisExtent: 250.0,
                            maxCrossAxisExtent:
                                MediaQuery.of(context).size.width / 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FadeIn(
                                duration: const Duration(milliseconds: 400),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade500,
                                  child: Card(
                                    elevation: 3,
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    child: const SizedBox(
                                      height: 150,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: 10,
                        )
                      : cubit.getCategoryDetailsModel.isNotEmpty
                          ? GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                mainAxisExtent: 250.0,
                                maxCrossAxisExtent:
                                    MediaQuery.of(context).size.width / 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return HomeFeedsDetails(
                                            productId: cubit
                                                .catModelDetailsIdes[index],
                                            value: cubit
                                                .getCategoryDetailsModel[index]
                                                .view,
                                            uid: cubit
                                                .getCategoryDetailsModel[index]
                                                .uId!,
                                          );
                                        },
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          var begin = const Offset(1.0, 0.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;
                                          var tween = Tween(
                                                  begin: begin, end: end)
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
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            242, 242, 242, 1),
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            cubit.getCategoryDetailsModel[index]
                                                .images!.first,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: cubit.getCategoryDetailsModel.length,
                            )
                          : Center(
                              child: Image.network(Constant.imageNotFound),
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
