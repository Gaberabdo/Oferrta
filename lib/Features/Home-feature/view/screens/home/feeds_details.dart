import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_state.dart';
import 'package:sell_4_u/Features/Home-feature/models/product_model.dart';
import 'package:sell_4_u/core/constant.dart';

import '../../../../../generated/l10n.dart';

class HomeFeedsDetails extends StatelessWidget {
  const HomeFeedsDetails({
    super.key,
    required this.model,
    required this.isCat,
    this.catIdString = '',
    this.productId = '',
  });

  final ProductModel model;
  final String productId;
  final bool isCat;
  final String catIdString;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedsCubit()
        ..getUserData(id: model.uId!)
        ..updateValue(
          value: model,
          isCat: isCat,
          catIdString: catIdString,
          productId: productId,
        ),
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
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.heart,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: model!.images!.asMap().entries.map(
                        (e) {
                          final index = e.key;
                          final imageUrl = e.value;
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(242, 242, 242, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image(
                                    image: NetworkImage(imageUrl),
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 50,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: ColorStyle.gray,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.image),
                                          Text(
                                              '${index + 1}/${cubit.imageList.length}')
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
                        height: 200,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(242, 242, 242, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.visibility_outlined,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  model.view.toString(),
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
                                Container(
                                  height: 22,
                                  width: 1,
                                  color: Colors.black38,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Icon(
                                  Icons.timelapse_outlined,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  transform(model.time!),
                                  style: FontStyleThame.textStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  height: 22,
                                  width: 1,
                                  color: Colors.black38,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  model.cat!,
                                  style: FontStyleThame.textStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontColor: ColorStyle.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              model.reasonOfOffer!,
                              style: FontStyleThame.textStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontColor: ColorStyle.primaryColor,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              model.price,
                              style: FontStyleThame.textStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontColor: ColorStyle.primaryColor,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  IconlyLight.location,
                                  size: 18,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  model.location.toString(),
                                  style: FontStyleThame.textStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(242, 242, 242, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).description,
                              style: FontStyleThame.textStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontColor: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 100,
                              width: double.infinity,
                              child: Text(
                                model.description!,
                                overflow: TextOverflow.ellipsis,
                                style: FontStyleThame.textStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  fontColor: Colors.black38,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(242, 242, 242, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(cubit.userModel ==
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
                                    fontWeight: FontWeight.w700,
                                    fontColor: Colors.black,
                                  ),
                                ),
                                Text(
                                  cubit.userModel == null
                                      ? "9988545"
                                      : cubit.userModel!.phone!,
                                  style: FontStyleThame.textStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontColor: Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 170,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(242, 242, 242, 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          zoom: 10,
                          target: LatLng(
                            model.lan!,
                            model.lat!,
                          ),
                        ),
                        buildingsEnabled: true,
                        compassEnabled: true,
                        myLocationEnabled: true,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: true,
                        myLocationButtonEnabled: true,

                        onMapCreated: (controller) {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorStyle.primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 3,
                          shape: (RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                        ),
                        onPressed: () {
                          cubit.makePhoneCall(phone: cubit.userModel!.phone!);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              IconlyLight.call,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              S.of(context).callMe,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(37, 211, 102, 1),
                          foregroundColor: Colors.white,
                          elevation: 3,
                          shape: (RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                        ),
                        onPressed: () {
                          cubit.openWhatsApp(phone: cubit.userModel!.phone!);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              height: 25,
                              width: 25,
                              fit: BoxFit.contain,
                              color: Colors.white,
                              image: NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/sales-b43bd.appspot.com/o/image-removebg-preview%20(1).png?alt=media&token=750dc901-f549-4782-b22d-3d21b97a8666'),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              S.of(context).whatsapp,
                            ),
                          ],
                        ),
                      ),
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
