// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sell_4_u/Admin/Features/Block-user-feature/manger/block-user-state.dart';
// import 'package:sell_4_u/Admin/Features/Block-user-feature/view/screens/user-action-screen.dart';
// import 'package:sell_4_u/Admin/Features/Block-user-feature/view/widget/all-user-widget.dart';
//
// import '../../../../../generated/l10n.dart';
// import '../../manger/block-user-cubit.dart';
//
// class BlockUserScreen extends StatelessWidget {
//   const BlockUserScreen({Key? key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => BlockUserCubit()..getAllUserData(),
//       child: BlocBuilder<BlockUserCubit, BlockUserStates>(
//         builder: (context, state) {
//           var cubit = BlocProvider.of<BlockUserCubit>(context);
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('All Users'),
//             ),
//             body: SingleChildScrollView(
//               child: BlocBuilder<BlockUserCubit, BlockUserStates>(
//                 builder: (context, state) {
//                   var cubit = BlocProvider.of<BlockUserCubit>(context);
//                   return state is GetAllUserLoadingHomePageStates
//                       ? Center(child: CircularProgressIndicator())
//                       : state is GetAllUserSuccessHomePageStates
//                       ? GridView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//                       mainAxisExtent: 240.0,
//                       maxCrossAxisExtent: 240.0,
//                       crossAxisSpacing: 12,
//                       mainAxisSpacing: 12,
//                     ),
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () {
//
//                           Navigator.push(context, MaterialPageRoute(builder: (context){
//                             return UserActionScreen( user: cubit.allUser[index]);
//                           }));
//                         },
//                         borderRadius: BorderRadius.circular(8),
//                         child: AllUser(model: cubit.allUser[index]),
//                       );
//                     },
//                     shrinkWrap: true,
//                     itemCount: cubit.allUser.length,
//                   )
//                       : state is GetAllUserErrorHomePageStates
//                       ? Center(
//                     child: Text('Error fetching users'),
//                   )
//                       : SizedBox();
//                 },
//               ),
//             ),
//           );
//
//
//
//         },
//       ),
//     );
//   }
// }
