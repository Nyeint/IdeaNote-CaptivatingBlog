import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/features/blog/data/datasources/blog/blog.dart';
import 'package:intl/intl.dart';
import '../../../../core/core.dart';
import '../../../../route/route_names.dart';
import '../../../auth/presentation/providers/profile_provider.dart';
import '../providers/blog_provider.dart';
import '../providers/check_state_provider.dart';
import 'blogger_list_dialog.dart';

class BlogDetailExpand extends ConsumerStatefulWidget {
  const BlogDetailExpand({Key? key}) : super(key: key);

  @override
  BlogDetailExpandState createState() => BlogDetailExpandState();
}

class BlogDetailExpandState extends ConsumerState<BlogDetailExpand> {
  bool isActive=false;

  @override
  Widget build(BuildContext context) {
    Blog blog = ref.read(blogProvider).blogDetail as Blog;
    return FittedBox(
      fit: BoxFit.fitWidth,
      alignment: Alignment.center,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: (){
                          ref.read(tabIndex.notifier).state = 0;
                          context.goNamed(RouteNames.viewBlog);
                        },
                        icon: Icon(Icons.arrow_back_ios_new_rounded, color: ColorResources.primary,)
                    ),
                    Expanded(child: Text(blog.title,style: k2dSemiBold,))
                  ],
                ).pad(top: 10,bottom: 10),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
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
                            image: Image.network(Gravatar('${blog.user.username.toLowerCase()}@gmail.com').imageUrl()).image,
                            fit: BoxFit.cover
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: ColorResources.secondary)
                    ),
                  ),
                ).pad(right: 10),
                Text(
                  blog.user.accountName.toString(),
                  style: k2dSemiBold.copyWith(fontSize: 18),
                ),
              ],
            ).pad(left: 15,right: 15),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      DateFormat('MMM d, yyyy').format(DateTime.parse(blog.updatedAt.toString())
                      ).toString()
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () async {
                            if(!isActive){
                              setState(() {
                                isActive=true;
                              });
                              bool alreadyVoted= blog.voter!.any((voter) => voter.objectId == ref.read(profileProvider).user!.objectId);
                              if(!alreadyVoted){
                                await ref.read(blogProvider).voteBlog(objectId: blog.objectId);
                                setState(() {
                                  isActive=false;
                                });
                              }
                              else{
                                await ref.read(blogProvider).removeVote(objectId: blog.objectId);
                                setState(() {
                                  isActive=false;
                                });
                              }
                            }
                          },
                          icon:
                          Icon(
                              blog.voter!.any((voter) => voter.objectId == ref.read(profileProvider).user!.objectId)?
                              Icons.favorite:
                              Icons.favorite_border)),
                      GestureDetector(
                        onTap: (){
                          bloggerListDialog(blog);
                        },
                        child:
                        Text(
                            '${blog.voter!.isEmpty?'':'${blog.voter!.length} '}'
                                '${blog.voter!.length>1?'votes':'vote'}'),
                      )
                    ],
                  )
                ],
              ).pad(left: 15,right: 15),
            ),
          ],
        ),
      ),
    );
  }
}
