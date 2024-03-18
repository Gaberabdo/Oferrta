import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_state.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:shimmer/shimmer.dart';

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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
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
                              cubit.catIdString = cubit.catModelIdes[index];
                            },
                            child: Container(
                              height: 20,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorStyle.primaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  cubit.catModel[index].categoryName!,
                                  style: FontStyleThame.textStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16,
                                    fontColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: cubit.catModel.length,
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
                          itemCount: 10,
                        )
                      : GridView.builder(
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
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return HomeFeedsDetails(
                                        model: cubit.getCategoryDetailsModel[index],
                                        productId: cubit.catModelDetailsIdes[index],
                                        catIdString: cubit.catIdString!,
                                        isCat: true,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(242, 242, 242, 1),
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        cubit.getCategoryDetailsModel[index]
                                            .images!.first!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: cubit.getCategoryDetailsModel.length,
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
