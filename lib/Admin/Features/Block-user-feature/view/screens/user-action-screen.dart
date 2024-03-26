import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-cubit.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-state.dart';
import 'package:sell_4_u/Features/Auth-feature/manger/model/user_model.dart';
import 'package:sell_4_u/core/constant.dart';

import '../../../../../generated/l10n.dart';

class UserActionScreen extends StatelessWidget {
  UserActionScreen({required this.user});


  UserModel user;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlockUserCubit()..getAllUserData(),
      child: BlocConsumer<BlockUserCubit, BlockUserStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit=BlockUserCubit.get(context);
          Color containerColor = user.blocked == true ? Colors.green : Colors.red;
          return Scaffold(
            backgroundColor: Colors.grey.shade200,

            appBar: AppBar(
              title: Text(user.name!, style: GoogleFonts.tajawal(
                fontSize: 18,
                fontWeight:FontWeight.w700
              )),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,


            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ///update user
                  Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Update User',
                            style: GoogleFonts.tajawal(
                                color: Colors.grey.shade700,
                                fontSize: 18,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        height: 55,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Update User',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color:ColorStyle.primaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  cubit.block(user.uId!);
                                },
                                child: Text('Update User',
                                  style: GoogleFonts.tajawal(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )


                      ),
                      const SizedBox(
                        height: 30,
                      ),

                    ],
                  ),
                  ///delete user
                  Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Delete User',
                            style: GoogleFonts.tajawal(
                                color: Colors.grey.shade700,
                                fontSize: 18,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                          height: 55,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delete User',
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color:Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: MaterialButton(
                                  onPressed: () {
                                    cubit.block(user.uId!);
                                  },
                                  child: Text('Delete User',
                                    style: GoogleFonts.tajawal(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )


                      ),
                      const SizedBox(
                        height: 30,
                      ),

                    ],
                  ),
                  ///block user
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            user.blocked == true ? 'Unblock User' : 'Block User',
                            style: GoogleFonts.tajawal(
                                color: Colors.grey.shade700,
                                fontSize: 18,
                                fontWeight: FontWeight.w700
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      BlocBuilder<BlockUserCubit, BlockUserStates>(
                        builder: (context, state) {
                          return Container(
                              height: 55,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              child:  Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      height: 45,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: Text(user.name!,
                                        style: GoogleFonts.tajawal(
                                            fontSize:16,
                                            fontWeight:FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (user.blocked == true) // Render Unblock button if blocked
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                          cubit.unblock(user.uId!);
                                        },
                                        child: Text(S.of(context).unblock,
                                          style: GoogleFonts.tajawal(
                                              color: Colors.white,
                                              fontSize:16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (user.blocked != true) // Render Block button if not blocked
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: MaterialButton(
                                        onPressed: () {
                                          cubit.block(user.uId!);
                                        },
                                        child: Text(S.of(context).block,
                                          style: GoogleFonts.tajawal(
                                              color: Colors.white,
                                              fontSize:16,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                    ],
                  )


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
