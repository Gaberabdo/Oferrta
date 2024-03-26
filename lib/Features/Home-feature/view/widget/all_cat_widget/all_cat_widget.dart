import 'package:flutter/material.dart';
import 'package:sell_4_u/Features/Home-feature/models/category_model.dart';
import 'package:sell_4_u/core/constant.dart';

class AllCategory extends StatelessWidget {
  const AllCategory({super.key, required this.model});

  final CategoryModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        CircleAvatar(
          radius: 40,
          backgroundColor: ColorStyle.gray,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35,
            backgroundImage: NetworkImage(
              model.image!,
              scale: 1,
              headers: {
                'Access-Control-Allow-Origin': 'gs://sales-b43bd.appspot.com',
              },
            ),
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          model.categoryName!,
          style: FontStyleThame.textStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),

      ],
    );
  }
}
