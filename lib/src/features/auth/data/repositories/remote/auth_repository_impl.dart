import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_notes/src/features/auth/data/datasources/user/user.dart';
import 'package:idea_notes/src/features/auth/domain/entities/user_model.dart';
import 'package:idea_notes/src/helpers/error_handling/unknown_exception.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../../../domain/repositories/remote/auth_repository.dart';

final authRepositoryProvider=Provider((ref) => AuthRepositoryImpl());

class AuthRepositoryImpl implements AuthRepository{

  @override
  Future<void> forgotPassword({required String email}) async{
    try{
      final ParseUser user = ParseUser(null, null, email);
      var response = await user.requestPasswordReset();

      if (!response.success){
        throw UnknownException(response.error!.message.toString());
      }
    }
    catch(e){
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<UserModel> logIn({required String userName, required String password}) async {
    try{
      final user = ParseUser(userName, password, null);
      final response = await user.login();
      if(!response.success){
        throw UnknownException(response.error!.message.toString());
      }
      return User.fromParseObject(response.results!.first);
    }
    catch(e){
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<void> logOut() async{
    try{
      final user=await ParseUser.currentUser();

      var response = await user.logout();
      if (!response.success){
        throw UnknownException(response.error!.message.toString());
      }
    }
    catch(e){
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<UserModel> signUp({required String userName, required String password, required String email, required String accountName}) async {
    try{
      final user = ParseUser.createUser(userName, password, email)
      ..set('accountName', accountName);
      var response = await user.signUp();
      if(!response.success){
        throw UnknownException(response.error!.message.toString());
      }
      return User.fromParseObject(response.result);
    }
    catch(e){
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<UserModel> changeAccountName({required String accountName}) async {
    try {
      ParseUser user=await ParseUser.currentUser();
      user.set('accountName', accountName);
      ParseResponse response = await user.save();
      if(!response.success){
        throw UnknownException(response.error!.message.toString());
      }
      return User.fromParseObject(response.results!.first);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}