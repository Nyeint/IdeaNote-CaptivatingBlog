import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class CustomPasswordTextForm extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  String validationText;
  bool showPassword;
  VoidCallback onTap;
  String? passwordLengthWarning;
  String? passwordNotMatch;
  bool? isConfirmPassword;
  String? passwordToConfirm;

  CustomPasswordTextForm({Key? key,
    required this.controller,
    required this.hintText,
    required this.validationText,
    required this.showPassword,
    required this.onTap,
    this.passwordLengthWarning,
    this.passwordNotMatch,
    this.isConfirmPassword,
    this.passwordToConfirm

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      obscureText: !showPassword,
      style: k2dRegular.copyWith(color: ColorResources.textPrimary),
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
          suffixIcon: !showPassword?
          IconButton(
            onPressed: onTap,
           icon: const Icon(Icons.lock,size: 25,),
           // icon: SvgPicture.string(SvgImages.remove_eye,width: 25,height: 25,color: Colors.black45,),
          ):
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.lock_open_outlined,size: 25,),
          )
      ),
      validator: (value) {
        if(value!.isEmpty) {
          return validationText;
        }
        else if(passwordLengthWarning!=null && value.length<8){
          return passwordLengthWarning;
        }
        else if(isConfirmPassword!=null && passwordToConfirm!=value){
          return passwordNotMatch;
        }
        return null;
      },
    );
  }
}
