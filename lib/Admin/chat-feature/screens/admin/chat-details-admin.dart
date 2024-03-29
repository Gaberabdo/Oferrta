import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-state.dart';
import 'package:sell_4_u/core/constant.dart';
import '../../../../Features/Auth-feature/manger/model/user_model.dart';
import '../../../Features/Block-user-feature/manger/block-user-cubit.dart';
import '../../cubit/chat-cubit.dart';
import '../../cubit/chat-states.dart';
import '../../models/chat_model.dart';

class ChatDetailsAdmin extends StatelessWidget {
  ChatDetailsAdmin({
    super.key,
    required this.model,
  });

  final UserModel model;
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatCubit()..getMessage(receiveId: model.uId!),
        ),
        BlocProvider(
          create: (context) => BlockUserCubit()..getAllUserData(),
        ),
      ],
      child: BlocConsumer<ChatCubit, ChatStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          var cubitTest = BlockUserCubit.get(context);
          return Row(
            children: [
              BlocConsumer<BlockUserCubit, BlockUserStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Expanded(
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return buildCommentItemUser(
                                  context: context,
                                  model: cubitTest.allUser[index],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemCount: cubitTest.allUser.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                flex: 2,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Set the border radius as desired
                    // Define your custom shape here
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        centerTitle: false,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(cubit.userModel == null ? model.image! : cubit.userModel!.image!),
                              backgroundColor: Colors.white,
                              radius: 25,
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              cubit.userModel == null ? model.name! : cubit.userModel!.name!,
                              style: FontStyleThame.textStyle(
                                fontColor: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      body: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    if ("7QfP0PNO6qVWVKij4jJzVNCG9sj2" ==
                                        cubit.messages[index].senderId) {
                                      return myMessages(
                                          cubit.messages[index], context);
                                    } else {
                                      return senderMessage(
                                          cubit.messages[index], context);
                                    }
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 10,
                                      ),
                                  itemCount: cubit.messages.length),
                            ),
                          ),
                          if(cubit.messages.isEmpty)
                            const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (cubit.chatImage != null)
                                  Stack(
                                    children: [
                                      Expanded(
                                        child: Image.file(
                                          cubit.chatImage!,
                                          height: 200,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          cubit.removePostImage();
                                        },
                                        icon: const CircleAvatar(
                                          child: Icon(Icons.close),
                                        ),
                                      ),
                                    ],
                                  ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                242, 242, 242, 1),
                                            borderRadius: BorderRadius.circular(8)),
                                        child: TextFormField(
                                          cursorColor: Colors.blue,
                                          controller: textController,
                                          onFieldSubmitted: (value) {
                                            cubit.sendMessage(
                                              text: textController.text,
                                              receiverId: cubit.userModel == null ? model.uId! : cubit.userModel!.uId!,
                                            );
                                            textController.clear();
                                          },
                                          keyboardType: TextInputType.text,
                                          keyboardAppearance: Brightness.dark,
                                          decoration: InputDecoration(
                                            hintText: 'Write Message...',
                                            hintStyle: FontStyleThame.textStyle(
                                              fontSize: 16,
                                              fontColor: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundColor: ColorStyle.primaryColor,
                                      child: IconButton(
                                        onPressed: () {
                                          cubit.sendMessage(
                                            text: textController.text,
                                            receiverId: cubit.userModel == null ? model.uId! : cubit.userModel!.uId!,
                                          );
                                          textController.clear();
                                        },
                                        icon: const Icon(
                                          IconlyLight.send,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget myMessages(MessageModel model, context) {
  return Align(
    alignment: AlignmentDirectional.bottomStart,
    child: Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(229, 244, 255, 1),
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.done_all,
                  size: 12,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  transform(model.time!),
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    '${model.message}',
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
            if (model.image != '')
              Image.network(
                model.image.toString(),
                height: 150,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    ),
  );
}

Widget senderMessage(MessageModel model, context) {
  return Align(
    alignment: AlignmentDirectional.bottomEnd,
    child: Container(
      decoration: const BoxDecoration(
        color: const Color.fromRGBO(242, 242, 242, 1),
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    '${model.message}',
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  transform(model.time!),
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  width: 4,
                ),
                const Icon(
                  Icons.done_all,
                  size: 12,
                ),
              ],
            ),
            if (model.image != '')
              Image.network(
                model.image.toString(),
                height: 150,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    ),
  );
}

Widget buildCommentItemUser({
  required BuildContext context,
  required UserModel model,
}) {
  return Container(
    decoration: BoxDecoration(
      color: ColorStyle.gray,
      borderRadius: const BorderRadiusDirectional.all(
        Radius.circular(
          12,
        ),
      ),
    ),
    child: InkWell(
      onTap: () {
        ChatCubit.get(context).changeUser(model);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(model.image!),
              backgroundColor: Colors.white,
              radius: 25,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              model.name!,
              style:
                  FontStyleThame.textStyle(fontSize: 16, fontColor: Colors.black),
            ),
          ],
        ),
      ),
    ),
  );
}
