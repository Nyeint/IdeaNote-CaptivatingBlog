import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../../../../auth/data/datasources/user/user.dart';
import '../../../domain/entities/blog_model.dart';
part 'blog.freezed.dart';
part 'blog.g.dart';

@freezed
class Blog with _$Blog implements BlogModel {
  factory Blog({
    required String objectId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String title,
    required String? content,
    required User user,
    required List<User>? voter,
  }) = _Blog;

  // static Future<Blog> fromParseRelationObject(ParseObject parseObject) async {
  //   final objectId = parseObject.get<String>('objectId');
  //   final createdAt = parseObject.get<DateTime>('createdAt');
  //   final updatedAt = parseObject.get<DateTime>('updatedAt');
  //   final title = parseObject.get<String>('title');
  //   final content = parseObject.get<String>('content');
  //   final user = parseObject.get<ParseObject>('user');
  //   final voter = parseObject.get<ParseObject>('voter');
  //
  //   return Blog(objectId: objectId.toString(), createdAt: createdAt!,
  //       updatedAt: updatedAt!, title: title!, content: content!, user: User.fromParseObject(user!),
  //       // voter: voter!
  //   );
  // }

  factory Blog.fromParseObject(
      ParseObject parseObject, List<ParseObject> voterList) {
    final objectId = parseObject.get<String>('objectId');
    final createdAt = parseObject.get<DateTime>('createdAt');
    final updatedAt = parseObject.get<DateTime>('updatedAt');
    final title = parseObject.get<String>('title');
    final content = parseObject.get<String>('content');
    final user = parseObject.get<ParseObject>('user');

    List<User> voterUserList =
        voterList.map((object) => User.fromParseObject(object)).toList();

    return Blog(
        objectId: objectId!,
        createdAt: createdAt!,
        updatedAt: updatedAt!,
        title: title!,
        content: content,
        user: User.fromParseObject(user!),
        voter: voterUserList);
  }

  factory Blog.fromJson(Map<String, dynamic> json) => _$BlogFromJson(json);
}
