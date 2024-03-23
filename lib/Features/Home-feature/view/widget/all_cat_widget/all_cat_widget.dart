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
        Container(
          height: 90,
          width: MediaQuery.of(context).size.width / 3.1,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(242, 242, 242, 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  height: 50,
                  width: 50,
                  image: NetworkImage(
                    model.image!,
                    scale: 1,
                    headers: {
                      'Access-Control-Allow-Origin': 'gs://sales-b43bd.appspot.com',
                    },
                  ),
                ),
              ),
              Text(
                model.categoryName!,
                style: FontStyleThame.textStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
