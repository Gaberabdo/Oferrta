import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_state.dart';
import 'package:sell_4_u/Features/Home-feature/models/category_model.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/constant.dart';
import 'feeds_details.dart';

class CatDetails extends StatelessWidget {
  const CatDetails({
    super.key,
    required this.categoryModel,
    required this.catModelIds,
  });

  final CategoryModel categoryModel;
  final String catModelIds;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedsCubit()..getCategoryDetails(catModelIds),
      child: BlocConsumer<FeedsCubit, FeedsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = FeedsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              centerTitle: true,
              automaticallyImplyLeading: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 16,
                ),
              ),
              title: Text(
                categoryModel.categoryName.toString(),
                style: FontStyleThame.textStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            body: (state is GetCategoryLoading)
                ? GridView.builder(
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 250.0,
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
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
                : cubit.getCategoryDetailsModel.isNotEmpty
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
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
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return HomeFeedsDetails(
                                      uid:cubit.getCategoryDetailsModel[index].uId!,
                                      value: cubit.getCategoryDetailsModel[index].view!,
                                      productId: cubit.catModelDetailsIdes[index],
                                    );
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
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(242, 242, 242, 1),
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
                      )
                    : Center(
                        child: Image.network(Constant.imageNotFound),
                      ),
          );
        },
      ),
    );
  }
}
