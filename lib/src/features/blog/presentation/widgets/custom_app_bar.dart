import 'package:flutter/material.dart';
import 'package:idea_notes/src/core/core.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String text;
  VoidCallback onTap;
  Widget? widget;
  bool hasWidget;

  CustomAppBar({Key? key, required this.text, required this.onTap, this.widget, this.hasWidget=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: onTap,
                  icon: Icon(Icons.arrow_back_ios_new_rounded, color: ColorResources.primary,)
              ).pad(right: 20),
              Text(text,
                overflow: TextOverflow.ellipsis,
                style: k2dSemiBold.copyWith(color: ColorResources.textPrimary),),
            ],
          ),
          hasWidget?widget!:Container()
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
