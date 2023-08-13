
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:idea_notes/src/features/blog/data/datasources/blog/blog.dart';
import 'package:idea_notes/src/features/blog/domain/entities/blog_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../../../../helpers/error_handling/unknown_exception.dart';
import '../../domain/repositories/blog_repository.dart';

final blogRepositoryProvider = Provider((ref) => BlogRepositoryImpl());

class BlogRepositoryImpl implements BlogRepository {
  @override
  Future<void> createBlog(
      {required String title,
      required String content,
      required String userId}) async {
    try {
      var blog = ParseObject('blog')
        ..set('title', title)
        ..set('content', content)
        ..set('user', (ParseObject('_User')..objectId = userId).toPointer());

      await blog.save().then((value) async {
        if (!value.success) {
          throw UnknownException(value.error.toString());
        }
      });
    }catch (e) {
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<void> deleteBlog({required String id}) async {
    try {
      var data = ParseObject('blog')..objectId = id;
      await data.delete().then((value) {
        if (!value.success) {
          throw UnknownException(value.error.toString());
        }
      });
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<void> updateBlog(
      {required String objectId,
      required String title,
      required String content}) async {
    try {
      var blog = ParseObject('blog')
        ..objectId = objectId
        ..set('title', title)
        ..set('content', content);
      await blog.update().then((value) {
        if (!value.success) {
          throw UnknownException(value.error.toString());
        }
      });
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> viewAllBlog({required int limit}) async {
    try {
      final QueryBuilder<ParseObject> parseQuery =
          QueryBuilder<ParseObject>(ParseObject('blog'))
            ..includeObject(['user']);
      // ..excludeKeys(['ACL','voter','content']);
      parseQuery.setLimit(limit);
      final ParseResponse response = await parseQuery.query();

      /// get relation by id
      if (!response.success) {
        throw UnknownException(response.error!.message.toString());
      } else {
        if (response.results == null) {
          return <Blog>[];
        }
        List<Blog> blogList = [];
        for (var i = 0; i < response.results!.length; i++) {
          final voterRelation =
              response.results![i].get<ParseRelation<ParseObject>>('voter');
          final voterList = await voterRelation.getQuery().find();
          blogList.add(
              Blog.fromParseObject(response.results![i], voterList));
        }
        return blogList;
      }
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> viewMyBlog(
      {required String userId, required int limit}) async {
    try {
      final QueryBuilder<ParseObject> parseQuery =
          QueryBuilder<ParseObject>(ParseObject('blog'))
            ..whereEqualTo(
                'user', (ParseObject('_User')..objectId = userId).toPointer())
            ..includeObject(['user']);
      parseQuery.setLimit(limit);
      final response = await parseQuery.query();

      if (!response.success) {
        throw UnknownException(response.error!.message.toString());
      } else {
        if (response.results == null) {
          return <Blog>[];
        }
        List<Blog> blogList = [];
        for (var i = 0; i < response.results!.length; i++) {
          final voterRelation =
              response.results![i].get<ParseRelation<ParseObject>>('voter');
          final voterList = await voterRelation.getQuery().find();
          blogList.add(
              Blog.fromParseObject(response.results![i],voterList));
        }
        return blogList;
      }
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<void> voteBlog({required String objectId}) async {
    try {
      final user = await ParseUser.currentUser();
      final blog = ParseObject('blog')
        ..objectId = objectId
        ..addRelation('voter', [user]);
      ParseResponse response = await blog.update();
      if (!response.success) {
        throw UnknownException(response.error!.message.toString());
      }
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<BlogModel> viewBlogDetail({required String objectId}) async {
    try {
      final parseQuery = QueryBuilder<ParseObject>(ParseObject('blog'))
        ..whereEqualTo('objectId', objectId)
        ..includeObject(['user']);

      final response = await parseQuery.query();

      if (!response.success) {
        throw UnknownException(response.error!.message.toString());
      } else {
        final voterRelation =
            response.results!.first.get<ParseRelation<ParseObject>>('voter');
        final voterList = await voterRelation.getQuery().find();
        return Blog.fromParseObject(response.results!.first,voterList);
      }
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  @override
  Future<void> removeVote({required String objectId}) async {
    try {
      final user = await ParseUser.currentUser();
      final blog = ParseObject('blog')
        ..objectId = objectId
        ..removeRelation('voter', [user]);
      await blog.update();
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}
