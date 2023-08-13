import 'package:flutter/material.dart';
import 'package:idea_notes/src/core/core.dart';

class CustomizedButton extends StatelessWidget {
  String name;
  VoidCallback onTap;
  double? width;
  Color? color;
  CustomizedButton({Key? key, required this.name, required this.onTap,this.width,this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: onTap,
        child:  Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            shape: BoxShape.rectangle,
            color: ColorResources.primary
          ),
          width: width??context.width,
          child: Center(
            child: Text(name,style: k2dMedium.copyWith(
              // color: ColorResources.textSecondary
            ),
            ),
          ),
        ),
    );
  }
}
