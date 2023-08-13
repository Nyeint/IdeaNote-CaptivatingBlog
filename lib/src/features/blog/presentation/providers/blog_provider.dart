import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_notes/src/features/blog/data/datasources/blog/blog.dart';
import 'package:idea_notes/src/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:idea_notes/src/features/blog/domain/usecases/blog_detail_usecase.dart';
import 'package:idea_notes/src/features/blog/domain/usecases/create_blog_usecase.dart';
import 'package:idea_notes/src/features/blog/domain/usecases/delete_blog_usecase.dart';
import 'package:idea_notes/src/features/blog/domain/usecases/update_blog_usecase.dart';
import 'package:idea_notes/src/features/blog/domain/usecases/vote_blog_usecase.dart';
import 'package:idea_notes/src/helpers/error_handling/unknown_exception.dart';
import '../../../../helpers/utils/utility.dart';
import '../../../auth/presentation/providers/profile_provider.dart';
import '../../domain/usecases/view_blog_usecase.dart';

final selectedBlogId = StateProvider<String>(
        (ref) => 'blogid');

final blogProvider = ChangeNotifierProvider(
    (ref) => BlogController(ref.container));

class BlogController extends ChangeNotifier {
  ProviderContainer container;
  BlogController(this.container);
  List<Blog> blogList = [];
  List<Blog> myBlogList = [];
  bool isViewBlogLoading=false;
  bool isMyViewBlogLoading=false;
  Blog? blogDetail;
  int limitAllBlog = 10;
  bool hasReachMaxAllBlog=false;
  int limitMyBlog = 10;
  bool hasReachMaxMyBlog=false;

  refreshViewAllBlog() async{
    limitAllBlog=10;
    hasReachMaxAllBlog=false;
    notifyListeners();
    await viewAllBlog();
  }

  nextViewAllBlog() async{
    limitAllBlog+=10;
    notifyListeners();
    await viewAllBlog();
  }

  refreshViewMyBlog() async{
    limitMyBlog=10;
    hasReachMaxMyBlog=false;
    notifyListeners();
    await viewMyBlog();
  }

  nextViewMyBlog() async{
    limitMyBlog+=10;
    notifyListeners();
    await viewMyBlog();
  }

  Future<void> createBlog({required String title, required String content}) async {
    CreateBlogUseCase useCase = CreateBlogUseCase(container.read(blogRepositoryProvider));
    var userId=container.read(profileProvider).user!.objectId;
    Utility.showLoader(show: true);
    try {
      await useCase.createBlog(title: title, content: content,userId: userId).then((value) {
        Utility.showLoader(show: false);
        Utility.showToast(message: 'successfully created');
        refreshViewMyBlog();
      });
    } on UnknownException catch (e) {
      Utility.showLoader(show: false);
      Utility.showToast(message: e.message.toString(), isError: true);
    }
  }

  Future<void> viewAllBlog() async {
    isViewBlogLoading=true;
    notifyListeners();
    ViewBlogUseCase useCase = ViewBlogUseCase(container.read(blogRepositoryProvider));
    // Utility.showLoader(show: true);
    try {
      List<Blog> model = await useCase.viewAllBlog(limit: limitAllBlog) as List<Blog>;
      if(limitAllBlog>model.length){
        blogList = model;
        hasReachMaxAllBlog=true;
      }
      else{
        blogList = model;
      }
      isViewBlogLoading=false;
      notifyListeners();
    } on UnknownException catch (e) {
      isViewBlogLoading=false;
      notifyListeners();
      Utility.showLoader(show: false);
      Utility.showToast(message: e.message.toString(), isError: true);
    }
  }

  Future<void> viewMyBlog() async {
    isMyViewBlogLoading=true;
    notifyListeners();
    ViewBlogUseCase useCase = ViewBlogUseCase(container.read(blogRepositoryProvider));
    try {
      var userId=container.read(profileProvider).user!.objectId;
      List<Blog> model = await useCase.viewMyBlog(userId: userId,limit: limitMyBlog) as List<Blog>;
      if(limitMyBlog>model.length){
        hasReachMaxMyBlog=true;
        myBlogList = model;
      }
      else{
        myBlogList = model;
      }
      isMyViewBlogLoading=false;
      notifyListeners();
      //Utility.showLoader(show: false);
    } on UnknownException catch (e) {
      isMyViewBlogLoading=false;
      notifyListeners();
      Utility.showLoader(show: false);
      Utility.showToast(message: e.message.toString(), isError: true);
    }
  }

  Future<void> updateBlog(
      {required String objectId, required String title, required String content}) async {
    UpdateBlogUseCase useCase = UpdateBlogUseCase(container.read(blogRepositoryProvider));
    Utility.showLoader(show: true);
    try {
      await useCase.updateBlog(objectId: objectId, title: title, content: content).then((value) {
        Utility.showLoader(show: false);
        Utility.showToast(message: 'successfully updated');
        viewMyBlog();
      });
    } on UnknownException catch (e) {
      Utility.showLoader(show: false);
      Utility.showToast(message: e.message.toString(), isError: true);
    }
  }

  Future<void> delete({required String id}) async {
    DeleteBlogUseCase useCase = DeleteBlogUseCase(container.read(blogRepositoryProvider));
    Utility.showLoader(show: true);
    try {
      await useCase.deleteBlog(id: id).then((value) {
        blogList.removeWhere((element) => (element).objectId == id);
        myBlogList.removeWhere((element) => (element).objectId == id);
        notifyListeners();

        Utility.showLoader(show: false);
        Utility.showToast(message: 'successfully deleted');
      });
    } on UnknownException catch (e) {
      Utility.showLoader(show: false);
      Utility.showToast(message: e.message, isError: true);
    }
  }

  Future<void> getBlogDetail({required String blogId})async {
    BlogDetailUseCase useCase = BlogDetailUseCase(container.read(blogRepositoryProvider));
    try{
      Blog blogDetailData = (await useCase.viewBlogDetail(objectId: blogId)) as Blog;
      blogDetail=blogDetailData;
      for (int i = 0; i < blogList.length; i++) {
        if (blogList[i].objectId == blogId) {
          blogList[i]=blogDetailData;
          break;
        }
      }
      for (int i = 0; i < myBlogList.length; i++) {
        if (myBlogList[i].objectId == blogId) {
          myBlogList[i]=blogDetailData;
          break;
        }
      }
      notifyListeners();
    }on UnknownException catch (e) {
      notifyListeners();
      Utility.showToast(message: e.message, isError: true);
    }
  }

  Future<void> voteBlog({required String objectId}) async{
    VoteBlogUseCase useCase = VoteBlogUseCase(container.read(blogRepositoryProvider));
    try {
      await useCase.voteBlog(objectId: objectId);
      await getBlogDetail(blogId: objectId);
      Utility.showToast(message: 'successfully voted');
    } on UnknownException catch (e) {
      Utility.showToast(message: e.message, isError: true);
    }
  }

  Future<void> removeVote({required String objectId}) async{
    VoteBlogUseCase useCase = VoteBlogUseCase(container.read(blogRepositoryProvider));
    try {
      await useCase.removeVote(objectId: objectId);
      await getBlogDetail(blogId: objectId);
      Utility.showToast(message: 'successfully unvoted');
    } on UnknownException catch (e) {
      //Utility.showLoader(show: false);
      Utility.showToast(message: e.message, isError: true);
    }
  }
}
