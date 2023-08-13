import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/blog/data/datasources/blog/blog.dart';
import 'package:idea_notes/src/features/blog/presentation/providers/blog_provider.dart';
import 'package:idea_notes/src/route/route_names.dart';
import '../providers/check_state_provider.dart';
import '../widgets/blog_detail_expand.dart';

class SliverHeaderPersistentDelegate extends SliverPersistentHeaderDelegate {
  Blog blog;
  WidgetRef ref;
  SliverHeaderPersistentDelegate({required this.blog, required this.ref});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double shrinkPercentage = min(1, shrinkOffset / (maxExtent - minExtent));
    return Container(
      decoration:  shrinkPercentage != 1?null:
      BoxDecoration(
        border:Border(
          bottom: BorderSide(color: ColorResources.primary)
        )
      ),
      child: Material(
        elevation: 0,
        child: SafeArea(
          child:  Stack(
            alignment: Alignment.topCenter,
            children: [
              if (shrinkPercentage != 1)
                Opacity(
                    opacity: 1 - shrinkPercentage,
                    child:
                    const BlogDetailExpand()
                ),
              if (shrinkPercentage != 0)
                Opacity(
                    opacity: shrinkPercentage,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: (){
                                  ref.read(tabIndex.notifier).state = 0;
                                  context.goNamed(RouteNames.viewBlog);
                                },
                                icon: Icon(Icons.arrow_back_ios_new_rounded, color: ColorResources.primary,)
                            ),
                            Expanded(child: Text(blog.title
                              ,overflow: TextOverflow.ellipsis,))
                          ],
                        ),
                      ],
                    )
                )
            ],
          ),
        ),
      ),
    );
  }
  @override
  double get maxExtent => 200;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class BlogDetailView extends ConsumerStatefulWidget{
  Blog blog;
  BlogDetailView({Key? key, required this.blog}) : super(key: key);

  @override
  BlogDetailViewState createState() => BlogDetailViewState();
}

class BlogDetailViewState extends ConsumerState<BlogDetailView> {
  quill.QuillController quillController = quill.QuillController.basic();
  @override
  void initState(){
    super.initState();
    ref.read(blogProvider).blogDetail=widget.blog;
  }

  @override
  Widget build(BuildContext context) {
    quillController=quill.QuillController(document: quill.Document.fromJson(jsonDecode(widget.blog.content!)), selection: const TextSelection.collapsed(offset: 0),);
    return SafeArea(
        child: Scaffold(
          body:
          CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                floating: false,
                delegate: SliverHeaderPersistentDelegate(
                    blog: widget.blog,
                    ref: ref
                ),
              ),

              SliverFillRemaining(
                hasScrollBody: false,
                child:  Column(
                  children: [
                    quill.QuillEditor.basic(
                      controller: quillController,
                      readOnly: true,
                    ).pad(bottom: 15,top: 20,left: 15 ,right: 15),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}