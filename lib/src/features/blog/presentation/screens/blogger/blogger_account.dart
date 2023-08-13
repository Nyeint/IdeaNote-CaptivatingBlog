import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/blog/presentation/providers/blogger_provider.dart';
import 'package:idea_notes/src/route/route_names.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../../i18n/strings.g.dart';
import '../../providers/check_state_provider.dart';
import '../../widgets/blog_card.dart';

class BloggerAccount extends ConsumerStatefulWidget {
  String userId;
  BloggerAccount({Key? key, required this.userId}) : super(key: key);

  @override
  BloggerAccountState createState() => BloggerAccountState();
}

class BloggerAccountState extends ConsumerState<BloggerAccount> {
  Gravatar? gravatar;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  bool isLoading = true;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(bloggerProvider).getBloggerInfo(userId: widget.userId).then((value) async {
        await ref.read(bloggerProvider).viewBlog(userId: widget.userId).then((value){
          Future.delayed(const Duration(seconds: 1),(){
            setState(() {
              isLoading=false;
            });
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body:  isLoading?const Center(child: CircularProgressIndicator(),):
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            ref.read(tabIndex.notifier).state = 0;
                            context.goNamed(RouteNames.viewBlog);
                          },
                          icon: Icon(Icons.arrow_back_ios_new_rounded, color: ColorResources.primary,)
                      ),
                      Container(
                        width: 65,
                        height: 65,
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
                                  image: Image.network(Gravatar('${ref.read(bloggerProvider).blogger!.username.toLowerCase()}@gmail.com').imageUrl()).image,
                                  fit: BoxFit.cover
                              ),
                              shape: BoxShape.circle
                          ),
                        ),
                      ).pad(right: 10),
                      Text(
                        ref.watch(bloggerProvider).blogger!.accountName.toString(),
                        style: k2dSemiBold.copyWith(color: ColorResources.textPrimary),
                      ),
                    ],
                  )
                ],
              ).pad(top: 10, bottom: 10),
              Expanded(
                child:
                ref.watch(bloggerProvider).isBlogLoading && ref.read(bloggerProvider).blogList.isEmpty?
                const Center(child: CircularProgressIndicator(),):ref.watch(bloggerProvider).blogList.isEmpty?
                Center(child: Text(Translations.of(context).blog.no_blog,
                  style: k2dRegular.copyWith(color: ColorResources.textPrimary),)):
                SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    enablePullUp: !ref.watch(bloggerProvider).hasReachMax,
                    header: const WaterDropHeader(),
                    onRefresh: ()async{
                      await ref.watch(bloggerProvider).refreshBlogList(userId: widget.userId).then((value){
                        _refreshController.refreshCompleted();
                      });
                    },
                    onLoading: ()async{
                      await  ref.watch(bloggerProvider).nextBlogList(userId: widget.userId);
                      _refreshController.loadComplete();
                    },
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: ref.watch(bloggerProvider).blogList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: (){
                                context.goNamed(RouteNames.blogDetail,extra: ref.watch(bloggerProvider).blogList[index]);
                              },
                              child:
                              BlogCardView(
                                  blog: ref
                                      .watch(bloggerProvider)
                                      .blogList[index]
                              )
                          );
                        }
                        )
                ),
              ),
            ],
          ),
        )
    );
  }
}
