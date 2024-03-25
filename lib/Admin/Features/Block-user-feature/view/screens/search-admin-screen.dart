import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-cubit.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-state.dart';
import 'package:sell_4_u/Admin/Features/Block-user-feature/view/screens/user-action-screen.dart';
import 'package:sell_4_u/Features/setting/Cubit/setting_cubit.dart';
import 'package:sell_4_u/Features/setting/Cubit/setting_state.dart';

import '../../../../../Features/Home-feature/view/widget/all_most_popular_widget/all_most_popular_widget.dart';
import '../../../../../core/constant.dart';
import '../../../../../core/helper/component/component.dart';
import '../../../../../generated/l10n.dart';


class SearchAdminScreen extends StatelessWidget {
  SearchAdminScreen({Key? key}) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlockUserCubit()..searchUsers(searchController.text),
      child: BlocConsumer<BlockUserCubit, BlockUserStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          final cubit = BlocProvider.of<BlockUserCubit>(context);

          return Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).search,
                style: FontStyleThame.textStyle(),
              ),
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
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormWidget(
                      emailController: searchController,
                      prefixIcon: const Icon(
                        IconlyLight.search,
                        size: 15,
                      ),
                      onChanged: (value) {
                       cubit.searchUsers(value); // Trigger search
                      },
                      hintText: S.of(context).search,
                      validator: '',
                      obscureText: false,
                      icon: false,
                      enabled: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is LoadingGetCategoriesData)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 5,
                    ),
                    if (state is SuccessGetCategoriesData)
                      ListView.builder(
                        itemCount: cubit.searchList.length,
                        itemBuilder: (context, index) {
                          final user = cubit.searchList[index];
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
                      ),
                    if (state is ErrorGetCategoriesData)
                      Center(
                        child: Image.network(Constant.imageNotFound),
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
