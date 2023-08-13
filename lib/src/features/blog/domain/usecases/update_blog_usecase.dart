import 'package:idea_notes/src/features/blog/domain/repositories/blog_repository.dart';

class UpdateBlogUseCase{
  final BlogRepository repository;
  UpdateBlogUseCase(this.repository);
  Future<void> updateBlog({required String objectId, required String title, required String content}){
    return repository.updateBlog(objectId: objectId,title: title,content: content);
  }
}