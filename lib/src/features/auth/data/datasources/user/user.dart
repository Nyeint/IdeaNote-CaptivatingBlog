import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:idea_notes/src/features/auth/domain/entities/user_model.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User implements UserModel {
  const factory User(
      {
        required String objectId,
        required DateTime createdAt,
        required String username,
        String? email,
        required String accountName,
      }) = _User;

  factory User.fromParseObject(ParseObject parseObject) {
    final objectId = parseObject.get<String>('objectId');
    final createdAt = parseObject.get<DateTime>('createdAt');
    final username = parseObject.get<String>('username');
    final email = parseObject.get<String>('email')??'';
    final accountName = parseObject.get<String>('accountName');
    return User(
        objectId: objectId!,
        createdAt: createdAt!,
        username: username!,
        email: email,
        accountName: accountName!
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
