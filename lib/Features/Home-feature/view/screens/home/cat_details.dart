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
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 250.0,
                      maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
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
                                  catIdString: catModelIds,
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
                              color: const Color.fromRGBO(242, 242, 242, 1),
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  cubit.getCategoryDetailsModel[index].images!
                                      .first!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: cubit.getCategoryDetailsModel.length,
                  ),
          );
        },
      ),
    );
  }
}
