import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idea_notes/src/core/color_resources.dart';
import 'package:idea_notes/src/route/route.dart';
import 'package:loader_overlay/loader_overlay.dart';

class Utility{
  static showToast({bool isError=false, required String message}){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: isError?Colors.red:ColorResources.primary,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static showLoader({bool show = false}){
    if(globalContext==null){
      return;
    }
    else{
      if(!globalContext!.mounted) return;
      show?globalContext!.loaderOverlay.show():globalContext!.loaderOverlay.hide();
    }
  }

  // static Future<List?> getVoterList(ParseRelation<ParseObject> parseObject)async{
  //
  //   List<ParseObject> parseObjectList =await parseObject.getQuery().find();
  //   List<String> voterList = [];
  //   for(ParseObject object in parseObjectList){
  //     voterList.add(object.objectId.toString());
  //   }
  //   return voterList;
  // }
}