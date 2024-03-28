import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_state.dart';
import 'package:sell_4_u/Features/Home-feature/models/product_model.dart';
import 'package:sell_4_u/Features/Home-feature/view/screens/home/feeds_details.dart';
import 'package:sell_4_u/Features/comment/controller/Commet_cubit/comment_cubit.dart';
import 'package:sell_4_u/core/constant.dart';

import '../../../../../core/helper/cache/cache_helper.dart';
import '../../../../../core/responsive_screen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../comment/view/screens/get_comment.dart';

class HomeFeedsDetailsDash extends StatelessWidget {
  const HomeFeedsDetailsDash({
    super.key,
    required this.productId,
    required this.uid,
    required this.value,
  });

  final String uid;
  final String productId;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeedsCubit()
            ..getUserData(id: uid)
            ..updateValue(productId: productId, value: value)
            ..getDetailsProData(
              id: productId,
            ),
        ),
        BlocProvider(
          create: (context) => CommentCubit()
            ..getComment(productId: productId)
            ..getUser(),
        ),
      ],
      child: BlocConsumer<FeedsCubit, FeedsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = FeedsCubit.get(context);
          ProductModel modelDetails = cubit.modelDetails;
          if (ResponsiveScreen.isMobile(context)) {
            return HomeFeedsDetails(
              productId: productId,
              uid: uid,
              value: value,
            );
          } else {
            return Scaffold(
              body: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Set the border radius as desired
                            // Define your custom shape here
                          ),
                          elevation: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            // Set the border radius as desired

                            child: Stack(
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                if (modelDetails.images != null)
                                  CarouselSlider(
                                    items: modelDetails.images!
                                        .asMap()
                                        .entries
                                        .map(
                                      (e) {
                                        final index = e.key;
                                        final imageUrl = e.value;
                                        return Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                242, 242, 242, 1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Stack(
                                            alignment: AlignmentDirectional
                                                .bottomStart,
                                            children: [
                                              Image(
                                                image: NetworkImage(imageUrl),
                                                fit: BoxFit.cover,
                                                height: 400,
                                                width: double.infinity,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 50,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                    color: ColorStyle.gray,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(Icons.image),
                                                        Text(
                                                            '${index + 1}/${modelDetails.images!.length}')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    options: CarouselOptions(
                                      height: 400,
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: false,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: false,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          const Duration(seconds: 1),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                Row(
                                  children: [
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        cubit.updateValueFavBool();
                                        cubit.updateValueFav(
                                            value: modelDetails,
                                            productId: productId);
                                      },
                                      icon: Icon(
                                        cubit.isFav == true
                                            ? IconlyBold.heart
                                            : IconlyLight.heart,
                                        color: cubit.isFav == true
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Set the border radius as desired
                            // Define your custom shape here
                          ),
                          elevation: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  modelDetails.cat ?? 'category',
                                  style: FontStyleThame.textStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.normal,
                                    fontColor: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.toString(),
                                      style: FontStyleThame.textStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Views',
                                      style: FontStyleThame.textStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(
                                      Icons.timelapse_outlined,
                                      size: 14,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      transform(modelDetails.time ??
                                          'Tue Mar 29 2024 16:25:43 GMT+0530 (IST)'),
                                      style: FontStyleThame.textStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      IconlyLight.location,
                                      size: 14,
                                      color: ColorStyle.primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        modelDetails.location ?? 'location',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: FontStyleThame.textStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ',',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: FontStyleThame.textStyle(
                                        fontWeight: FontWeight.w600,
                                        fontColor: ColorStyle.gray,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Icon(
                                      Icons.bar_chart,
                                      size: 14,
                                      color: ColorStyle.primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        modelDetails.reasonOfOffer ?? 'reason',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: FontStyleThame.textStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ',',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: FontStyleThame.textStyle(
                                        fontWeight: FontWeight.w600,
                                        fontColor: ColorStyle.gray,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Icon(
                                      Icons.attach_money,
                                      size: 14,
                                      color: ColorStyle.primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        modelDetails.price ?? 'price',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: FontStyleThame.textStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  S.of(context).description,
                                  style: FontStyleThame.textStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    fontColor: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    final textSpan = TextSpan(
                                      text: modelDetails.description ??
                                          'description',
                                      style: FontStyleThame.textStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        fontColor: Colors.black38,
                                      ),
                                    );
                                    final textPainter = TextPainter(
                                      text: textSpan,
                                      textDirection: TextDirection.ltr,
                                      maxLines: 3,
                                    );
                                    textPainter.layout(
                                        maxWidth: constraints.maxWidth);
                                    final isTextOverflowing =
                                        textPainter.didExceedMaxLines;

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text.rich(
                                          textSpan,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                        ),
                                        if (isTextOverflowing) // Add message if text exceeds three lines
                                          const Text(
                                            '...',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black38,
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Set the border radius as desired
                            // Define your custom shape here
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(cubit
                                              .userModel ==
                                          null
                                      ? "https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg?w=740&t=st=1710334520~exp=1710335120~hmac=f053daa6a74128973e2f7512cd8b6eaae51a0716ece0866a6b355e1c900a61e6"
                                      : cubit.userModel!.image!),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cubit.userModel == null
                                          ? "user"
                                          : cubit.userModel!.name!,
                                      style: FontStyleThame.textStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        fontColor: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      "Owner",
                                      style: FontStyleThame.textStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontColor: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    cubit.makePhoneCall(
                                        phone: cubit.userModel!.phone!);
                                  },
                                  color: ColorStyle.primaryColor,
                                  icon: const Icon(
                                    IconlyLight.call,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.openWhatsApp(
                                        phone: cubit.userModel!.phone!);
                                  },
                                  color: const Color.fromRGBO(37, 211, 102, 1),
                                  icon: const Icon(
                                    IconlyLight.chat,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: BlocConsumer<CommentCubit, CommentState>(
                            listener: (context, state) {
                              // TODO: implement listener
                            },
                            builder: (context, state) {
                              var cubit = CommentCubit.get(context).commentPost;
                              return Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // Set the border radius as desired
                                  // Define your custom shape here
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'All Offers',
                                          style: FontStyleThame.textStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            fontColor: ColorStyle.primaryColor,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: GetComment(productId: productId),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
