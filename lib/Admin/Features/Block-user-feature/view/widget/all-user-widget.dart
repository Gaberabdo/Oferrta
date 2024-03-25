import 'package:flutter/material.dart';
import 'package:sell_4_u/Features/Auth-feature/manger/model/user_model.dart';
import 'package:sell_4_u/core/constant.dart';

class AllUser extends StatelessWidget {
  const AllUser({Key? key, required this.model});

  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(

            color: Colors.grey
          )
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  model.image!,
                  fit: BoxFit.cover, // Make the image fill the container
                  headers: {
                    'Access-Control-Allow-Origin': 'gs://sales-b43bd.appspot.com',
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  model.name!,
                  style: FontStyleThame.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
