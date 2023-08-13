import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/blog/presentation/widgets/blog_card.dart';
import 'package:idea_notes/src/route/route_names.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../i18n/strings.g.dart';
import '../../../auth/presentation/providers/profile_provider.dart';
import '../providers/blog_provider.dart';

class ViewBlog extends ConsumerStatefulWidget {
  const ViewBlog({Key? key}) : super(key: key);

  @override
  ViewBlogState createState() => ViewBlogState();
}

class ViewBlogState extends ConsumerState<ViewBlog> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(ref.watch(blogProvider).blogList.isEmpty){
        viewAllBlog();
      }
    });
  }

  Future<void> viewAllBlog() async {
    await ref.read(blogProvider).viewAllBlog();
  }
  @override
  Widget build(BuildContext context) {
    List blogList =  ref.watch(blogProvider).blogList;
    final translate = Translations.of(context);

    return blogList.isEmpty && ref.watch(blogProvider).isViewBlogLoading
        ? const Center(child: CircularProgressIndicator(),):
    blogList.isEmpty?
    Center(child: Text(Translations.of(context).blog.no_blog).pad(top: 100))
        : SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: !ref.watch(blogProvider).hasReachMaxAllBlog,
      header: const WaterDropHeader(),
      onRefresh: ()  async{
        await ref.read(blogProvider).refreshViewAllBlog().then((value){
          _refreshController.refreshCompleted();
        });
      },
      onLoading: () async{
        await  ref.read(blogProvider).nextViewAllBlog();
        _refreshController.loadComplete();
      },

      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: blogList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                ref.read(blogProvider).blogDetail=blogList[index];
                context.goNamed(RouteNames.blogDetail,extra: blogList[index]);
              },
              onTapDown: (TapDownDetails details) {
                if(ref.watch(profileProvider).user!.objectId==blogList[index].user.objectId){
                  double left = details.globalPosition.dx;
                  double top = details.globalPosition.dy;
                  showMenu(
                      context: context,
                      position:
                      RelativeRect.fromLTRB(left, top-100, 0, 0),
                      items: <PopupMenuEntry>[
                        PopupMenuItem(
                          value: "edit",
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context, "edit");
                                context.goNamed(RouteNames.editBlog,extra: ref.watch(blogProvider).blogList[index]);
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.edit,
                                  ),
                                  Text(translate.blog.edit)
                                ],
                              )),
                        ),
                        PopupMenuItem(
                          value: "delete",
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context, "delete");
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        content: Text(
                                            translate.blog.sure_delete,
                                            // "Are you sure you want to delete?",
                                            style:k2dMedium),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.pop(
                                                  context, 'Delete');
                                              ref.watch(blogProvider).delete(id: ref.watch(blogProvider).blogList[index].objectId);
                                            },
                                            child: Text(translate.blog.delete,
                                                style: k2dMedium),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(
                                                    context, 'Cancel'),
                                            child: Text(translate.blog.cancel,
                                                style: k2dMedium.copyWith(color: Theme.of(context).primaryColorDark)
                                            ),
                                          ),
                                        ],
                                      ),
                                );
                              },
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.delete,
                                  ),
                                  Text(
                                      translate.blog.delete
                                  )
                                ],
                              )
                          ),
                        ),
                      ]
                  );
                }
              },
              child:
              BlogCardView(
                blog: blogList[index]
              ),
            );
          }),
    );
  }
}
