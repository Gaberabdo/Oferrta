import 'package:animate_do/animate_do.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-cubit.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-state.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_state.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Home-feature/view/screens/home/feeds_details.dart';
import 'components/home_feeds_details_dash.dart';
import 'edit_cat.dart';

class BannerCatDash extends StatelessWidget {
  const BannerCatDash({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeedsCubit()..getCategory(),
        ),
      ],
      child: BlocConsumer<FeedsCubit, FeedsState>(
        listener: (context, state) {
          var cubit = FeedsCubit.get(context);

          if (state is GetCategorySuccess) {
            cubit.catIdString = cubit.catModelIdes.first;
            for (var element in cubit.catModel) {
              element.isSelected = false;
            }
            cubit.catModel[0].isSelected = true;

            cubit.getCategoryDetails(cubit.catModelIdes.first);
          }
        },
        builder: (context, state) {
          var cubit = FeedsCubit.get(context);
          var cubit2 = BlockUserCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  (cubit.catModel.isNotEmpty)
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 240,
                            mainAxisExtent: 50.0,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 20,
                                width: 210,
                                decoration: BoxDecoration(
                                    color:
                                        cubit.catModel[index].isSelected == true
                                            ? ColorStyle.primaryColor
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      style: cubit.catModel[index].isSelected ==
                                              true
                                          ? BorderStyle.none
                                          : BorderStyle.solid,
                                      color: Colors.black,
                                      width: 1,
                                    )),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        for (var element in cubit.catModel) {
                                          element.isSelected = false;
                                        }
                                        cubit.catModel[index].isSelected =
                                            !cubit.catModel[index].isSelected!;

                                        cubit.getCategoryDetails(
                                            cubit.catModelIdes[index]);
                                        cubit.catIdString =
                                            cubit.catModelIdes[index];
                                      },
                                      child: Text(
                                        cubit.catModel[index].categoryName!,
                                        style: FontStyleThame.textStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16,
                                          fontColor: cubit.catModel[index]
                                                      .isSelected ==
                                                  true
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      tooltip: 'Delete category',
                                      onPressed: () async {
                                        AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.warning,
                                            width: 400,
                                            animType: AnimType.rightSlide,
                                            title: 'Warning',
                                            desc:
                                                'Are You Sure To Delete This category...?',
                                            btnCancelOnPress: () {},
                                            btnOkOnPress: () {
                                              cubit.deleteCategory(
                                                  cubit.catModelIdes[index]);
                                            }).show();
                                      },
                                      icon: const Icon(
                                        IconlyBold.delete,
                                        size: 16,
                                        color: Colors.red,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    IconButton(
                                      tooltip: 'Edit category',
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: SizedBox(
                                                width: 400,
                                                height: 500,
                                                child: EditCategory(
                                                  model: cubit.catModel[index],
                                                  id: cubit.catModelIdes[index],
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) {
                                          cubit.getCategory();
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: cubit.catModel.length,
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 120,
                            // Set the maximum width of each item
                            mainAxisExtent: 50.0,
                            // Set the height of each item
                            mainAxisSpacing: 8,
                            // Set the spacing between items along the main axis
                            crossAxisSpacing: 8,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
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
                  const SizedBox(
                    height: 12,
                  ),
                  (state is GetCategoryLoading)
                      ? GridView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisExtent: 250.0,
                            maxCrossAxisExtent: 250,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
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
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                mainAxisExtent: 250.0,
                                maxCrossAxisExtent: 250.0,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: () {
                                      print('object');

                                      print(
                                        cubit.catModelDetailsIdes[index],
                                      );
                                      print(
                                        cubit.getCategoryDetailsModel[index]
                                            .view,
                                      );
                                      print(
                                        cubit
                                            .getCategoryDetailsModel[index]
                                            .uId!,
                                      );

                                      print(
                                        cubit
                                            .getCategoryDetailsModel[index]
                                            .uId,
                                      );


                                      print(
                                        cubit.catModelDetailsIdes[index],
                                      );
                                      cubit2.changeCurrent(
                                        index: 2,
                                        productIdIN:
                                            cubit.catModelDetailsIdes[index],
                                        valueIN: cubit
                                            .getCategoryDetailsModel[index]
                                            .view,
                                        uidOwnerIN: cubit
                                            .getCategoryDetailsModel[index]
                                            .uId!,
                                        catIiiid: cubit.catModelIdes[index],
                                        catProIdvvvv:
                                            cubit.catModelDetailsIdes[index],
                                      );
                                      print('object');
                                    },
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        shadows: const [
                                          BoxShadow(
                                            color: Color(0x14000000),
                                            blurRadius: 10,
                                            offset: Offset(0, 0),
                                            spreadRadius: 0,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12),
                                            ),
                                            child: Image.network(
                                              cubit
                                                      .getCategoryDetailsModel[
                                                          index]
                                                      .images!
                                                      .isEmpty
                                                  ? "https://via.placeholder.com/700"
                                                  : cubit
                                                      .getCategoryDetailsModel[
                                                          index]
                                                      .images!
                                                      .first,
                                              height: 190,
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, right: 4, top: 20),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(
                                                  IconlyLight.location,
                                                  size: 14,
                                                  color:
                                                      ColorStyle.primaryColor,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    cubit
                                                        .getCategoryDetailsModel[
                                                            index]
                                                        .location!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: FontStyleThame
                                                        .textStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontColor: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  ',',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      FontStyleThame.textStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontColor: ColorStyle.gray,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.attach_money,
                                                  size: 14,
                                                  color:
                                                      ColorStyle.primaryColor,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    cubit
                                                        .getCategoryDetailsModel[
                                                            index]
                                                        .price!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: FontStyleThame
                                                        .textStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontColor: ColorStyle
                                                          .primaryColor,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: cubit.getCategoryDetailsModel.length,
                            )
                          : Center(
                              child: Image.network(
                                height: 500,
                                width: 500,
                                Constant.imageNotFound,
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
