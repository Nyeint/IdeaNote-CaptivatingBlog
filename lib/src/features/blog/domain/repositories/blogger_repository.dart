import 'package:idea_notes/src/features/auth/domain/entities/user_model.dart';

abstract class BloggerRepository{
  Future<UserModel> getBloggerInfo({required String userId});
}