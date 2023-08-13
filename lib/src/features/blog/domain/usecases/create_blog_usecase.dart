import 'package:idea_notes/src/features/blog/domain/repositories/blog_repository.dart';

class CreateBlogUseCase{
  final BlogRepository repository;
  CreateBlogUseCase(this.repository);
  Future<void> createBlog({required String title, required String content, required String userId}){
    return repository.createBlog(title: title, content: content, userId: userId);
  }
}