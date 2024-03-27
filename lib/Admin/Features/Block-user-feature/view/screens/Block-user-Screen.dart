import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-state.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/view/screens/search-admin-screen.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/view/screens/update-user-screen.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/view/screens/user-action-screen.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/view/widget/all-user-widget.dart';

import '../../../../../Features/setting/view/screens/search_screen.dart';
import '../../../../../core/constant.dart';
import '../../../../../core/helper/component/component.dart';
import '../../../../../generated/l10n.dart';
import '../../manger/block-user-cubit.dart';

class BlockUserScreen extends StatelessWidget {
  const BlockUserScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlockUserCubit()..getAllUserData(),
      child: BlocBuilder<BlockUserCubit, BlockUserStates>(
        builder: (context, state) {

          var cubit = BlocProvider.of<BlockUserCubit>(context);
          if (state is DeleteSuccessUserDataState) {

            BlocProvider.of<BlockUserCubit>(context).getAllUserData();
          }
          return  Scaffold(
            appBar: AppBar(
              title: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) {
                        return SearchAdminScreen();
                      },
                      transitionsBuilder: (context, animation,
                          secondaryAnimation, child) {
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
                      transitionDuration:
                      const Duration(milliseconds: 500),
                    ),
                  );
                },
                child: TextFormWidget(
                  emailController: TextEditingController(),
                  prefixIcon: const Icon(
                    IconlyLight.search,
                    size: 15,
                  ),
                  hintText: S.of(context).search,
                  validator: '',
                  obscureText: false,
                  icon: false,
                  enabled: false,
                ),
              ),
            ),
            body: state is GetAllUserLoadingHomePageStates
                ? Center(child: CircularProgressIndicator())
                : state is GetAllUserSuccessHomePageStates
                ? ListView.builder(
              itemCount: cubit.allUser.length,
              itemBuilder: (context, index) {
                final user = cubit.allUser[index];
                return Padding(
                  padding: EdgeInsets.all(8), // Adjust padding here
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 140, // Adjust height as needed
                                      width: 120, // Adjust width as needed
                                      child: Image.network(
                                        user.image!,
                                        fit: BoxFit.cover,
                                        headers: {
                                          'Access-Control-Allow-Origin': 'gs://sales-b43bd.appspot.com',
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        user.name!,
                                        style: FontStyleThame.textStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color:ColorStyle.primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context){
                                      return EditProfileAdmin(model:user);
                                    }));
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
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color:Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                        cubit.deleteUser(uid: user.uId!);
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
                                const SizedBox(
                                  height: 8,
                                ),
                                if (user.blocked == true) // Render Unblock button if blocked
                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: MaterialButton(
                                      onPressed: () {
                                        cubit.unblock(user.uId!);
                                      },
                                      child: Text(
                                        S.of(context).unblock,
                                        style: GoogleFonts.tajawal(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (user.blocked != true) // Render Block button if not blocked
                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: MaterialButton(
                                      onPressed: () {
                                        cubit.block(user.uId!);
                                      },
                                      child: Text(
                                        S.of(context).block,
                                        style: GoogleFonts.tajawal(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            )

                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                );
              },
            )



                : state is GetAllUserErrorHomePageStates
                ? Center(
              child: Text('Error fetching users'),
            )
                : SizedBox(),
          );
          ;



        },
      ),
    );
  }
}
