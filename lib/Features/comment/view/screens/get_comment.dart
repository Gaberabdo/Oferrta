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
    return BlocConsumer<CommentCubit, CommentState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CommentCubit.get(context);
        var userModel = cubit.model;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
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
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 44,
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
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: ColorStyle.gray,
                      borderRadius: BorderRadiusDirectional.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        style: FontStyleThame.textStyle(
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          hintText: "Write Price...",
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
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    height: 44,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (textController.text.isNotEmpty && priceController.text.isNotEmpty) {
                          cubit.createComment(
                            productId: productId,
                            comment: textController.text,
                            name: userModel.name!,
                            image: userModel.image!,
                            price: double.parse(priceController.text),
                          );
                          textController.clear();
                          priceController.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: ColorStyle.primaryColor,
                        elevation: 0,
                        shape: (RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        )),
                      ),
                      child: Text(
                        isArabic() ? 'نعم' : 'Confirm',
                        style: FontStyleThame.textStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

        );
      },
    );
  }
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
                          fontSize: 16, fontColor: Colors.black),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .8,
                      child: Text(
                        commentModel.text!,
                        style: FontStyleThame.textStyle(
                            fontSize: 16, fontColor: Colors.black),
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
