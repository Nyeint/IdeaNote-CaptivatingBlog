import 'package:idea_notes/src/features/blog/domain/repositories/blog_repository.dart';

class DeleteBlogUseCase{
  final BlogRepository repository;
  DeleteBlogUseCase(this.repository);
  Future<void> deleteBlog({required String id}){
    return repository.deleteBlog(id: id);
  }
}