import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/auth/presentation/providers/profile_provider.dart';
import 'package:idea_notes/src/route/route_names.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../i18n/strings.g.dart';
import '../providers/blog_provider.dart';
import '../widgets/blog_card.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends ConsumerState<AccountScreen> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      if(ref.read(profileProvider).user==null){
        ref.read(profileProvider).isProfileLoading=true;
        await getUser();
      }
      if(ref.watch(blogProvider).myBlogList.isEmpty){
        await viewMyBlog();
      }
    });
  }

  Future<void> getUser() async {
    await ref.read(profileProvider).getUser();
  }

  Future<void> viewMyBlog() async {
    await ref.read(blogProvider).viewMyBlog();
  }

  @override
  Widget build(BuildContext context) {
    List blogList =  ref.watch(blogProvider).myBlogList;
    final translate = Translations.of(context);
    return
      Column(
      children: [
        ref.watch(profileProvider).isProfileLoading
            ? const Center(child: CircularProgressIndicator(),)
            :
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    border: Border.all(
                        color: Colors.white,
                        width: 2
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.network(Gravatar('${ref.read(profileProvider).user!.username.toLowerCase()}@gmail.com').imageUrl()).image,
                            fit: BoxFit.cover
                        ),
                        shape: BoxShape.circle
                    ),
                  ),
                ).pad(right: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ref.watch(profileProvider).user!.accountName.toString(),
                      style: k2dSemiBold.copyWith(color: ColorResources.textPrimary),
                    ),
                    Text(
                      ref.watch(profileProvider).user!.username.toString(),
                      style: k2dRegular.copyWith(color: ColorResources.textPrimary),
                    ),
                  ],
                )
              ],
            ),
            IconButton(
                onPressed: () {
                  context.goNamed(RouteNames.settings);
                },
                icon: Icon(Icons.settings,size: 30,color: ColorResources.dark,)),
          ],
        ).pad(top: 10, bottom: 10),

        blogList.isEmpty && ref.watch(blogProvider).isMyViewBlogLoading
            ? const Center(child: CircularProgressIndicator(),):
        blogList.isEmpty?
        Center(child: Text(translate.blog.no_blog,
          style: k2dRegular.copyWith(color: ColorResources.textPrimary),))
            :
        Align(
          alignment: Alignment.bottomLeft,
          child: Text("My Blogs",
            style: k2dMedium.copyWith(color: ColorResources.textPrimary,fontSize: 17),),
        ).pad(left: 10, bottom: 10,top: 10),
        Expanded(
          child:
          SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: !ref.watch(blogProvider).hasReachMaxMyBlog,
              header: const WaterDropHeader(),
              onRefresh: ()async{
              await ref.watch(blogProvider).refreshViewMyBlog().then((value){
                _refreshController.refreshCompleted();
              });
            },
            onLoading: ()async{
              await  ref.watch(blogProvider).nextViewMyBlog();
              _refreshController.loadComplete();
            },
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: ref.watch(blogProvider).myBlogList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: (){
                        // ref.read(blogProvider).blogDetail=myBlogList[index];
                        context.goNamed(RouteNames.blogDetail, extra: ref.watch(blogProvider).myBlogList[index]);
                      },
                      onTapDown: (TapDownDetails details) {
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
                                     // ref.watch(blogProvider).getBlogDetail(blogId: ref.watch(blogProvider).myBlogList[index].objectId);
                                      context.goNamed(RouteNames.editBlog,extra: ref.watch(blogProvider).myBlogList[index]);
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
                                                    ref.watch(blogProvider).delete(id: ref.watch(blogProvider).myBlogList[index].objectId);
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
                      },

                      child:
                      BlogCardView(
                        blog: ref
                            .watch(blogProvider)
                            .myBlogList[index],
                      )
                  );
                })
          ),
        ),
      ],
    );
  }
}