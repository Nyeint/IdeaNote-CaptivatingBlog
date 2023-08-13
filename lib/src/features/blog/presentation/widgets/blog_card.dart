import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_notes/src/core/core.dart';
import 'package:idea_notes/src/features/blog/data/datasources/blog/blog.dart';
import 'package:intl/intl.dart';

class BlogCardView extends ConsumerStatefulWidget {
  final Blog blog;
  const BlogCardView({Key? key,required this.blog}) : super(key: key);

  @override
  BlogCardViewState createState() => BlogCardViewState();
}

class BlogCardViewState extends ConsumerState<BlogCardView> {
  Gravatar? gravatar;
  @override
  void initState(){
    gravatar = Gravatar('${widget.blog.user.username.toLowerCase()}@gmail.com');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child:  CachedNetworkImage(
                  imageUrl: gravatar!.imageUrl(),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ).pad(right: 10),

              Expanded(child: SizedBox(
                height: 70,
                  child: Text(widget.blog.title,
                  style: k2dSemiBold.copyWith(fontSize: 16),)
              )
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.blog.user.accountName,style: k2dMedium,),
                  Text(
                    DateFormat('MMM d, yyyy').format(DateTime.parse(widget.blog.updatedAt.toString()),
                    ).toString(), style: k2dLight.copyWith(fontSize: 12,color: Colors.blue),
                  ),
                ],
              ),
              widget.blog.voter!.isNotEmpty?
              Align(alignment: Alignment.bottomRight,
                  child: Text('${widget.blog.voter!.length} ${widget.blog.voter!.length>1? 'votes':'vote'}')):
                  Container()
            ],
          ).pad(top: 10),
        ],
      ).pad(left: 10, right: 10, top: 10, bottom: 10),
    );
  }
}
