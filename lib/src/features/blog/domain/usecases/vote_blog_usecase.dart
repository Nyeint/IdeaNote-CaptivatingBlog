import 'package:idea_notes/src/features/blog/domain/repositories/blog_repository.dart';

class VoteBlogUseCase{
  final BlogRepository repository;
  VoteBlogUseCase(this.repository);
  Future<void> voteBlog({required objectId})async{
    return await repository.voteBlog(objectId: objectId);
  }
  Future<void> removeVote({required objectId})async{
    return await repository.removeVote(objectId: objectId);
  }
}