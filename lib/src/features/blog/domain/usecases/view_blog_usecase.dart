import 'package:idea_notes/src/features/blog/domain/repositories/blog_repository.dart';
import '../entities/blog_model.dart';

class ViewBlogUseCase{
  final BlogRepository repository;
  ViewBlogUseCase(this.repository);
  Future<List<BlogModel>> viewAllBlog({required int limit}) async{
    return await repository.viewAllBlog(limit: limit);
  }

  Future<List<BlogModel>> viewMyBlog({required String userId,required int limit}) async{
    return await repository.viewMyBlog(userId: userId,limit: limit);
  }
}