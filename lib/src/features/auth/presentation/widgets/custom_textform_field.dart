import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class CustomTextFormField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  String validationText;
  // Color? fillColor;
  int maxLines;
  int? maxLength;
  CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.validationText,
    // this.fillColor= Colors.white,
    // this.fillColor= const Color(0xffE2E2E2),
    this.maxLines=1,
    this.maxLength
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: 1,
      maxLines: maxLines,
      maxLength: maxLength,
      textInputAction: TextInputAction.go,
     // style: k2dRegular.copyWith(color: ColorResources.textPrimary),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 15.0, top: 12.0, bottom: 12.0),
          hintText: hintText,
          hintStyle: k2dRegular.copyWith(color: ColorResources.textMute),
          filled: true,
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: ColorResources.textMute)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: ColorResources.textMute)
          ),
      ),
      validator: (value) {
        if(value!.isEmpty ) {
          return validationText;
        }
        return null;
      },
    );
  }
}
