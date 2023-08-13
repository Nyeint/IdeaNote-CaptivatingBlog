import 'package:idea_notes/src/features/auth/domain/entities/user_model.dart';
import '../repositories/blogger_repository.dart';

class BloggerUseCase{
  final BloggerRepository repository;
  BloggerUseCase(this.repository);
  Future<UserModel> getBloggerInfo({required String userId}){
    return repository.getBloggerInfo(userId: userId);
  }
}