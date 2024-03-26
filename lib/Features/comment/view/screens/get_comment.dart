import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_4_u/Features/comment/controller/Commet_cubit/comment_cubit.dart';
import 'package:sell_4_u/core/constant.dart';
import 'package:sell_4_u/core/helper/cache/cache_helper.dart';

import '../../../Auth-feature/presentation/pages/login/login_screen.dart';
import '../../model/comment_model.dart';

class GetComment extends StatelessWidget {
  GetComment({
    super.key,
    required this.productId,
  });

  final String productId;
  final textController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommentCubit()
        ..getComment(
          productId: productId,
        )
        ..getUser(),
      child: BlocConsumer<CommentCubit, CommentState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = CommentCubit.get(context);
          var userModel = cubit.model;
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
                "Offers",
                style: FontStyleThame.textStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            body: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildCommentItem(
                    context: context,
                    commentModel: cubit.commentPost[index],
                  ),
                );
              },
              itemCount: cubit.commentPost.length,
            ),
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  color: ColorStyle.gray,
                  borderRadius: BorderRadiusDirectional.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: textController,
                    style: FontStyleThame.textStyle(
                      fontSize: 13,
                    ),
                    decoration: InputDecoration(
                      hintText: "Write Comment...",
                      counterStyle: FontStyleThame.textStyle(
                        fontSize: 13,
                      ),
                      hintStyle: FontStyleThame.textStyle(
                        fontSize: 13,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const VerticalDivider(
                            color: Colors.black,
                            // Specify the color of the divider
                            thickness: 1,
                            // Specify the thickness of the divider
                            width: 1, // Specify the width of the divider
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            width: 40,
                            child: Center(
                              child: TextFormField(
                                controller: priceController,
                                keyboardType: TextInputType.number,
                                style: FontStyleThame.textStyle(
                                  fontSize: 13,
                                ),
                                decoration: InputDecoration(
                                  hintText: "0",
                                  counterStyle: FontStyleThame.textStyle(
                                    fontSize: 13,
                                  ),
                                  hintStyle: FontStyleThame.textStyle(
                                    fontSize: 13,
                                  ),
                                  enabledBorder: InputBorder.none,
                                  focusColor: Colors.grey,
                                  focusedBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.black,
                            // Specify the color of the divider
                            thickness: 1,
                            // Specify the thickness of the divider
                            width: 1, // Specify the width of the divider
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          IconButton(
                            onPressed: () {
                              if (textController.text.isNotEmpty && priceController.text.isNotEmpty) {
                                if (CacheHelper.getData(key: 'uId') != null) {
                                  cubit.createComment(
                                    productId: productId,
                                    comment: textController.text,
                                    name: userModel!.name!,
                                    image: userModel.image!,
                                    price: double.parse(priceController.text),
                                  );
                                  textController.clear();
                                  priceController.clear();
                                } else {
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
                                }
                              }
                            },
                            icon: const Icon(Icons.near_me),
                          ),
                        ],
                      ),
                      enabledBorder: InputBorder.none,
                      focusColor: Colors.grey,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
        },
      ),
    );
  }

  Widget buildCommentItem({
    required BuildContext context,
    required CommentModel commentModel,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(commentModel.image!),
          backgroundColor: Colors.white,
          radius: 25,
        ),
        const SizedBox(
          width: 12,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorStyle.gray,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(0),
                    topEnd: Radius.circular(20),
                    bottomEnd: Radius.circular(20),
                    bottomStart: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        commentModel.name!,
                        style: FontStyleThame.textStyle(
                          fontSize: 16,
                          fontColor: Colors.black
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * .8,
                        child: Text(
                          commentModel.text!,
                          style: FontStyleThame.textStyle(
                              fontSize: 16,
                              fontColor: Colors.black
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  DefaultTextStyle(
                    style: FontStyleThame.textStyle(
                        fontColor: ColorStyle.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        commentModel.price.toString() + r"$",
                      ),
                    ),
                  ),
                  const Spacer(),
                  DefaultTextStyle(
                    style: FontStyleThame.textStyle(
                      fontColor: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        transform(commentModel.dataTime!),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
