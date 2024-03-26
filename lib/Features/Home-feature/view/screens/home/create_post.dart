import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_cubit.dart';
import 'package:sell_4_u/Features/Home-feature/Cubit/feeds_cubit/feeds_state.dart';
import 'package:sell_4_u/Features/Home-feature/view/layout.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/cache/cache_helper.dart';
import 'package:sell_4_u/core/helper/component/component.dart';

import '../../../../../generated/l10n.dart';
import '../../../models/category_model.dart';

class CreatePost extends StatelessWidget {
  const CreatePost({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeedsCubit()..getCategory(),
      child: BlocConsumer<FeedsCubit, FeedsState>(
        listener: (context, state) {
          var cubit = FeedsCubit.get(context);

          if (cubit.isLoading == false) {

            List<TextEditingController> controllers = [
              cubit.reasonController,
              cubit.detailController,
              cubit.descController,
              cubit.imageController,
              cubit.catController,
              cubit.locationController,
              cubit.priceController,
            ];

            for (var controller in controllers) {
              controller.clear();
            }
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return LayoutScreen();
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
          }
        },
        builder: (context, state) {
          var cubit = FeedsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 16,
                ),
              ),
              title: Text(
                S.of(context).postAd,
                style: FontStyleThame.textStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (cubit.imageList.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(242, 242, 242, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    cubit.pickImages();
                                  },
                                  child: Container(
                                    height: 160,
                                    color: ColorStyle.gray,
                                    child: const Center(
                                      child: Image(
                                        image: NetworkImage(
                                          'https://firebasestorage.googleapis.com/v0/b/sales-b43bd.appspot.com/o/image-removebg-preview%20(2).png?alt=media&token=240ba74f-db07-4bdc-a340-f8b10686ae1f',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: ColorStyle.gray,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: cubit.imageController,
                                      onTap: () {},
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        errorStyle: FontStyleThame.textStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                        errorBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        border: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                      ),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Please select at least one image';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    if (cubit.imageList.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CarouselSlider(
                          items: cubit.imageList.asMap().entries.map(
                            (e) {
                              final index = e.key;
                              final imageUrl = e.value;
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(242, 242, 242, 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    alignment: AlignmentDirectional.bottomStart,
                                    children: [
                                      Stack(
                                        children: [
                                          Image(
                                            height: 170,
                                            image: FileImage(imageUrl),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                          PopupMenuButton<int>(
                                            onCanceled: () {
                                              Navigator.of(context);
                                            },
                                            shape: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                borderSide: BorderSide.none),
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                value: 1,
                                                onTap: () {
                                                  cubit.pickImages();
                                                },
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Add image',
                                                      style: FontStyleThame
                                                          .textStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    const Icon(Icons.plus_one)
                                                  ],
                                                ),
                                              ),
                                              PopupMenuItem(
                                                value: 2,
                                                child: InkWell(
                                                  onTap: () {
                                                    cubit.deleteImage(
                                                        value: imageUrl);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "remove",
                                                        style: FontStyleThame
                                                            .textStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      const Icon(
                                                          IconlyLight.delete)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                            icon: const CircleAvatar(
                                              child: Icon(
                                                Icons.more_horiz,
                                              ),
                                            ),
                                            offset: const Offset(0, 20),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 50,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: ColorStyle.gray,
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                            autoPlayAnimationDuration:
                                const Duration(seconds: 1),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CatDropDown(
                        model: cubit.catModel,
                        cubit: cubit,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 60,
                        child: TextFormWidget(
                          maxLines: 2,
                          emailController: cubit.reasonController,
                          prefixIcon: const Icon(
                            Icons.access_time_filled,
                            size: 15,
                          ),
                          hintText: S.of(context).reasonAdd,
                          validator: S.of(context).reasonAdd,
                          obscureText: false,
                          icon: false,
                          enabled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 60,
                        child: TextFormWidget(
                          maxLines: 2,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          emailController: cubit.priceController,
                          prefixIcon: const Icon(
                            Icons.attach_money,
                            size: 15,
                          ),
                          hintText: 'Please write your price',
                          validator: 'Please write your price',
                          obscureText: false,
                          icon: false,
                          enabled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 90,
                        child: TextFormWidget(
                          maxLines: 2,
                          emailController: cubit.detailController,
                          prefixIcon: const Icon(
                            Icons.details,
                            size: 15,
                          ),
                          hintText: S.of(context).details,
                          validator: S.of(context).details,
                          obscureText: false,
                          icon: false,
                          enabled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 90,
                        child: TextFormWidget(
                          maxLines: 2,
                          emailController: cubit.descController,
                          prefixIcon: const Icon(
                            Icons.description,
                            size: 15,
                          ),
                          hintText: S.of(context).descriptionAdd,
                          validator: S.of(context).descriptionAdd,
                          obscureText: false,
                          icon: false,
                          enabled: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 111,
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(242, 242, 242, 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                        cubit.latitude ?? 20.0,
                                        cubit.longitude ?? 20.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width:
                                          MediaQuery.sizeOf(context).width * .6,
                                      child: TextFormField(
                                        controller: cubit.locationController,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'Please pressed on bottom to get current Location';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText:
                                              'Please pressed on bottom to get current Location',
                                          enabledBorder: InputBorder.none,
                                          hintStyle: FontStyleThame.textStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                          errorStyle: FontStyleThame.textStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                          errorBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          border: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    CircleAvatar(
                                      child: (state is GetLocationLoading)
                                          ? CircularProgressIndicator()
                                          : IconButton(
                                              onPressed: () {
                                                cubit.getCurrentPosition(
                                                    context);
                                              },
                                              icon: const Icon(
                                                IconlyLight.location,
                                              ),
                                            ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
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
                            if (cubit.formKey.currentState!.validate()) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return PlanChoose(cubit: cubit);
                                },
                              );
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                IconlyLight.upload,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              cubit.isLoading == true
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      S.of(context).createPost,
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

class PlanChoose extends StatefulWidget {
  const PlanChoose({
    super.key,
    required this.cubit,
  });

  final FeedsCubit cubit;

  @override
  State<PlanChoose> createState() => _PlanChooseState();
}

class _PlanChooseState extends State<PlanChoose> {
  bool isBasic = false;
  bool isPlan = false;
  bool isExtra = false;
  bool isSuper = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: AlertDialog(
        title: Text(
          'Choose on of suggested plans',
          style: FontStyleThame.textStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 111,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(242, 242, 242, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    isBasic = true;
                    isExtra = false;
                    isSuper = false;
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CircleAvatar(
                              radius: 9,
                              foregroundColor: Colors.black38,
                              child: CircleAvatar(
                                radius: 7,
                                backgroundColor: isBasic
                                    ? ColorStyle.primaryColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'Basic',
                            style: FontStyleThame.textStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          Spacer(),
                          Text(
                            r'7.5 $',
                            style: FontStyleThame.textStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 12, start: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Icon(
                                IconlyLight.time_circle,
                                size: 19,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'Pushed to product category for 30 Days',
                                maxLines: 1,
                                style: FontStyleThame.textStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    fontColor: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(242, 242, 242, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    isBasic = false;
                    isExtra = true;
                    isSuper = false;
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CircleAvatar(
                              radius: 9,
                              foregroundColor: Colors.black38,
                              child: CircleAvatar(
                                radius: 7,
                                backgroundColor: isExtra
                                    ? ColorStyle.primaryColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'Extra',
                            style: FontStyleThame.textStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          Spacer(),
                          Text(
                            r'13 $',
                            style: FontStyleThame.textStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 12, start: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Icon(
                                IconlyLight.time_circle,
                                size: 19,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'Pushed to product category for 30 Days',
                                maxLines: 1,
                                style: FontStyleThame.textStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontColor: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 12, start: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Icon(
                                Icons.move_up,
                                size: 19,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'Pin in most popular for 30 Days',
                                maxLines: 1,
                                style: FontStyleThame.textStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontColor: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(242, 242, 242, 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    isBasic = false;
                    isExtra = false;
                    isSuper = true;
                    setState(() {});
                  },
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CircleAvatar(
                              radius: 9,
                              foregroundColor: Colors.black38,
                              child: CircleAvatar(
                                radius: 7,
                                backgroundColor: isSuper
                                    ? ColorStyle.primaryColor
                                    : Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'Super',
                            style: FontStyleThame.textStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          Spacer(),
                          Text(
                            r'20 $',
                            style: FontStyleThame.textStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 12, start: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Icon(
                                IconlyLight.time_circle,
                                size: 19,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'Pushed to product category for 30 Days',
                                maxLines: 1,
                                style: FontStyleThame.textStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontColor: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 12, start: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Icon(
                                Icons.move_up,
                                size: 19,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'Pin in most popular for 30 Days',
                                maxLines: 1,
                                style: FontStyleThame.textStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontColor: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 12, start: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Icon(
                                Icons.notifications_active,
                                size: 19,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'Send notifications to all user',
                                maxLines: 1,
                                style: FontStyleThame.textStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontColor: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: FontStyleThame.textStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.cubit.uploadImages(uId: CacheHelper.getData(key: 'uId'));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorStyle.primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: (RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
            ),
            child: Text(
              'Submit',
              style: FontStyleThame.textStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CatDropDown extends StatelessWidget {
  const CatDropDown({
    super.key,
    required this.model,
    required this.cubit,
  });

  final List<CategoryModel> model;
  final FeedsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorStyle.gray,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: cubit.catController,
          onTap: () {
            showCategoryPicker(context);
          },
          decoration: InputDecoration(
            hintStyle: FontStyleThame.textStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            hintText: cubit.catValueString,
            enabledBorder: InputBorder.none,
            errorStyle: FontStyleThame.textStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            border: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
          validator: (test) {
            if (cubit.catController.text.isEmpty) {
              return 'Please select a category';
            }

            return null;
          },
        ),
      ),
    );
  }

  void showCategoryPicker(
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: model.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(model[index].categoryName!),
              onTap: () {
                cubit.catValueStringCreate(
                  value: model[index].categoryName!,
                  index: index,
                );

                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}
