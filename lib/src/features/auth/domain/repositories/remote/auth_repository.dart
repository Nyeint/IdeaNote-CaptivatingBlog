import 'package:idea_notes/src/features/auth/domain/entities/user_model.dart';

abstract class AuthRepository{
  Future<UserModel> logIn({required String userName,required String password});
  Future<void> logOut();
  Future<UserModel> signUp({required String userName,required String password,required String email, required String accountName});
  Future<void> forgotPassword({required String email});
  Future<UserModel> changeAccountName({required String accountName});
}