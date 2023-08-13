import 'package:idea_notes/src/features/blog/domain/repositories/blog_repository.dart';
import '../entities/blog_model.dart';

class BlogDetailUseCase{
  final BlogRepository repository;
  BlogDetailUseCase(this.repository);
  Future<BlogModel> viewBlogDetail({ required String objectId}){
    return repository.viewBlogDetail(objectId: objectId);
  }
}