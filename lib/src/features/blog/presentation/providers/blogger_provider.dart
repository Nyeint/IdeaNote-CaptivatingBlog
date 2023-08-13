import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_notes/src/features/auth/data/datasources/user/user.dart';
import 'package:idea_notes/src/features/blog/data/datasources/blog/blog.dart';
import 'package:idea_notes/src/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:idea_notes/src/features/blog/domain/usecases/blogger_usecase.dart';
import 'package:idea_notes/src/helpers/error_handling/unknown_exception.dart';
import '../../../../helpers/utils/utility.dart';
import '../../data/repositories/blogger_repositoyr_impl.dart';
import '../../domain/usecases/view_blog_usecase.dart';


final bloggerProvider = ChangeNotifierProvider(
        (ref) => BloggerController(ref.container));

class BloggerController extends ChangeNotifier {
  //BlogRepositoryImpl blogRepositoryProvider
  ProviderContainer container;
  BloggerController(this.container);
  List<Blog> blogList = [];
  bool isBlogLoading=true;
  int limit = 10;
  bool hasReachMax=false;
  User? blogger;

  refreshBlogList({required userId}) async{
    limit=10;
    hasReachMax=false;
    notifyListeners();
    await viewBlog(userId: userId);
  }

  nextBlogList({required userId}) async{
    limit+=10;
    notifyListeners();
    await viewBlog(userId: userId);
  }

  Future<void> getBloggerInfo({required userId}) async {
    BloggerUseCase useCase = BloggerUseCase(container.read(bloggerRepositoryProvider));
    try{
      await useCase.getBloggerInfo(userId: userId).then((value){
        blogger=value as User;
      });
    }on UnknownException catch (e) {
      Utility.showToast(message: e.message.toString(), isError: true);
    }
  }

  Future<void> viewBlog({required userId}) async {
    isBlogLoading=true;
    notifyListeners();
    ViewBlogUseCase useCase = ViewBlogUseCase(container.read(blogRepositoryProvider));
    try {
      List<Blog> model = await useCase.viewMyBlog(userId: userId,limit: limit) as List<Blog>;
      if(limit>model.length){
        hasReachMax=true;
        blogList = model;
      }
      else{
        blogList = model;
      }
      isBlogLoading=false;
      notifyListeners();
      } on UnknownException catch (e) {
        isBlogLoading=false;
        notifyListeners();
        Utility.showToast(message: e.message.toString(), isError: true);
      }
  }
}
