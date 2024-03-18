import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_state.dart';

import 'package:sell_4_u/Features/Home-feature/view/screens/home/cat_details.dart';
import 'package:sell_4_u/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/constant.dart';
import '../../widget/all_cat_widget/all_cat_widget.dart';
import '../../widget/all_most_popular_widget/all_most_popular_widget.dart';
import 'feeds_details.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedsCubit()
        ..getCategory()
        ..mostPopular(),
      child: BlocConsumer<FeedsCubit, FeedsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = FeedsCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (!cubit.isGetCategoryLoading)
                        ? GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 90.0,
                              maxCrossAxisExtent:
                                  MediaQuery.of(context).size.width / 3.1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return FadeIn(
                                duration: const Duration(milliseconds: 400),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade600,
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
                              );
                            },
                            itemCount: 12,
                          )
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 90.0,
                              maxCrossAxisExtent:
                                  MediaQuery.of(context).size.width / 3.1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return CatDetails(
                                          categoryModel: cubit.catModel[index],
                                          catModelIds:
                                              cubit.catModelIdes[index],
                                        );
                                      },
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: AllCategory(
                                  model: cubit.catModel[index],
                                ),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: cubit.catModel.length,
                          ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: ColorStyle.gray,
                              width: .5,
                            )),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                image: cubit.catModel.isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage(
                                        cubit.catModel.elementAt(8).image!,
                                        scale: 1,
                                      ))
                                    : null,
                                color: const Color.fromRGBO(242, 242, 242, 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).continueB,
                                  style: FontStyleThame.textStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  cubit.catModel.isNotEmpty
                                      ? cubit.catModel
                                          .elementAt(8)
                                          .categoryName!
                                      : "cate",
                                  style: FontStyleThame.textStyle(
                                    fontWeight: FontWeight.w600,
                                    fontColor: ColorStyle.primaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward,
                              color: ColorStyle.primaryColor,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 88,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(242, 242, 242, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      S.of(context).mostP,
                      style: FontStyleThame.textStyle(
                        fontColor: ColorStyle.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    (cubit.mostPopularModel.isEmpty)
                        ? GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 240.0,
                              maxCrossAxisExtent: 240.0,
                            ),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FadeIn(
                                  duration: const Duration(milliseconds: 400),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade700,
                                    highlightColor: Colors.grey.shade600,
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
                            itemCount: 12,
                          )
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              mainAxisExtent: 240.0,
                              maxCrossAxisExtent: 240.0,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  print(cubit.mostPopularModel[index].images);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return HomeFeedsDetails(
                                          model: cubit.mostPopularModel[index],
                                          isCat: false,
                                          productId:
                                              cubit.mostPopularIdes[index],
                                        );
                                      },
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: MostPopular(
                                  model: cubit.mostPopularModel[index],
                                ),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: cubit.mostPopularModel.length,
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
