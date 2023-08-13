import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_notes/src/features/auth/data/datasources/user/user.dart';
import 'package:idea_notes/src/features/auth/domain/entities/user_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../../../../helpers/error_handling/unknown_exception.dart';
import '../../domain/repositories/blogger_repository.dart';

final bloggerRepositoryProvider = Provider((ref) => BloggerRepositoryImpl());

class BloggerRepositoryImpl implements BloggerRepository{
  @override
  Future<UserModel> getBloggerInfo({required String userId}) async {
    try{
      final QueryBuilder<ParseObject> parseQuery = QueryBuilder<ParseObject>(ParseObject('_User'))
        ..whereEqualTo('objectId', userId);
      final ParseResponse response = await parseQuery.query();
      if(!response.success) {
        throw UnknownException(response.error!.message.toString());
      }
      else{
        return User.fromParseObject(response.results!.first);
      }
    }
    catch (e) {
      throw UnknownException(e.toString());
    }
  }
}