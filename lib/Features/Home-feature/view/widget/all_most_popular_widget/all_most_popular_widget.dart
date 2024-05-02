import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:sell_4_u/Features/Home-feature/models/product_model.dart';
import 'package:sell_4_u/core/constant.dart';

class MostPopular extends StatelessWidget {
  const MostPopular({super.key, required this.model});

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius:  BorderRadius.circular(12),
              child: Image(
                height: 135,
                width: double.infinity,
                fit: BoxFit.fill,
                image: NetworkImage(
                  (model.images!.isEmpty)
                      ? "https://via.placeholder.com/700"
                      : model.images!.first,
                  scale: 1,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              model.cat!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: FontStyleThame.textStyle(
                fontWeight: FontWeight.w600,
                fontColor: ColorStyle.primaryColor,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              model.reasonOfOffer!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: FontStyleThame.textStyle(
                fontWeight: FontWeight.w600,
                fontColor: Colors.black,
                fontSize: 14,
              ),
            ),
          ),



          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  IconlyLight.location,
                  size: 14,
                  color: ColorStyle.primaryColor,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    model.location!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FontStyleThame.textStyle(
                      fontWeight: FontWeight.w600,
                      fontColor: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  ',',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FontStyleThame.textStyle(
                    fontWeight: FontWeight.w600,
                    fontColor: ColorStyle.gray,
                    fontSize: 14,
                  ),
                ),
                Icon(
                  Icons.attach_money,
                  size: 14,
                  color: ColorStyle.primaryColor,
                ),
                Expanded(
                  child: Text(
                    model.price!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: FontStyleThame.textStyle(
                      fontWeight: FontWeight.w600,
                      fontColor: ColorStyle.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
