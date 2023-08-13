import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/blog/data/datasources/blog/blog.dart';
import 'package:idea_notes/src/route/route.dart';
import 'package:idea_notes/src/route/route_names.dart';

void bloggerListDialog(Blog blog){
  showDialog<void>(
    context: globalContext!,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${blog.voter!.length} ${blog.voter!.length>1?'voters':'voter'}",style: k2dRegular.copyWith(fontSize: 17),),
            TextButton(
              onPressed: ()=> Navigator.of(context).pop(),
              child: const Icon(Icons.close),
            ),
          ],
        ),
        content:
        SizedBox(
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: blog.voter!.length,
              itemBuilder: (context,index){
                return TextButton(
                  onPressed: (){
                    context.goNamed(RouteNames.bloggerAccount,
                    pathParameters: {'userId':blog.voter![index].objectId});
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(100)),
                          border: Border.all(
                              color: Colors.white,
                              width: 2
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: Image.network(Gravatar('${blog.voter![index].username.toLowerCase()}@gmail.com').imageUrl()).image,
                                  fit: BoxFit.cover
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(color: ColorResources.secondary)
                          ),
                        ),
                      ).pad(right: 10),
                      Expanded(child: Text(blog.voter![index].accountName,style: k2dRegular))
                    ],
                  ),
                );
              }),
        ),
      );
    },
  );
}